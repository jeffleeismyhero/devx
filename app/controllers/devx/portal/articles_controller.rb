
require_dependency "devx/application_controller"

module Devx
  class Portal::ArticlesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :article, class: 'Devx::Article'

    def index
    end

    def new
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)
    end

    def edit
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)
    end

    def create
      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)

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

    

    private

    def article_params
      accessible = [ :title, :slug, :short_description, :content, :image, :published_at, :tag_list ]
      params.require(:article).permit(accessible)
    end
  end
end
