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
      if @article.save
        redirect_to devx.portal_articles_path,
        notice: "Successfully created #{@article}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @article.update(article_params)
        redirect_to devx.portal_articles_path,
        notice: "Successfully updated #{@article}"
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


    private

    def article_params
      accessible = [ :title, :slug, :short_description, :content, :image, :published_at, :tag_list ]
      params.require(:article).permit(accessible)
    end
  end
end
