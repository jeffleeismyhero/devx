
require_dependency "devx/application_controller"

module Devx
  class Portal::ArticlesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :article, class: 'Devx::Article'

    def index
      respond_to do |format|
        format.html
        format.xlsx do
          render xlsx: 'index', filename: 'news_export.xlsx'
        end
      end
    end

    def new
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)
    end

    def edit
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)
    end

    def create
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)

      if @article.new_record?
        @article.user_id = current_user.id
      end

      if @article.save
        redirect_to devx.portal_articles_path,
        notice: "Successfully created #{@article.title}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)

      if @article.update(article_params)
        redirect_to devx.portal_articles_path,
        notice: "Successfully updated #{@article.title}"
      else
        render :edit,
        notice: 'An error occurred'
      end
    end

    def destroy
      if @article.destroy
        redirect_to devx.portal_articles_path,
        notice: "Successfully deleted #{@article.title}"
      else
        render :index,
        notice: 'An error occurred'
      end
    end

    def approve
      @article = Article.find(params[:id])

      if @article.update_columns(approved_by: current_user, approved_at: Time.zone.now)
        redirect_to devx.articles_path,
        notice: "Approved"
      else
        redirect_to devx.articles_path,
        notice: "Failed to approve"
      end
    end

    def import
      require 'csv'

      @import = Devx::Import.new(params[:import])
      @errors = 0;

      if request.post?

        if @import.valid?

          if records = CSV.read(@import.file.path, headers: true)
            logfile = File.open("#{Rails.root}/log/import.log", "a")
            logfile.sync = true
            logger = Logger.new(logfile)

            records.each_with_index do |record, index|

              title = record[0].to_s.squish
              description = record[1].to_s.squish
              content = record[2].to_s.squish
              published_at = record[3].to_s.squish
              author = record[4].to_s.squish
              categories = record[5].to_s.squish
              keywords = record[6].to_s.squish

              article = Devx::Article.new(
                title: title,
                short_description: description,
                content: content,
                published_at: published_at,
                user_id: Devx::User.get_user(author),
                tag_list: categories,
                keyword_list: keywords
              )

              if article.valid?
                logger.info "Expecting object to be valid: #{article.inspect}"
                article.save
              else
                logger.warn "Failed to import object: #{article.inspect}"
                article.errors.full_messages.try(:each) do |error|
                  logger.warn "#{error}"
                end
                @errors += 1
              end

            end

          end

        end
        redirect_to devx.portal_articles_path,
        notice: "#{@errors} articles could not be imported due to errors"

      end
    end


    private

    def article_params
      accessible = [ :title, :slug, :short_description, :content, :image, :published_at, tag_list: [], keyword_list: [] ]
      params.require(:article).permit(accessible)
    end
  end
end
