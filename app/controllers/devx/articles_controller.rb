require_dependency "devx/application_controller"

module Devx
  class ArticlesController < ApplicationController
    load_resource :article, class: 'Devx::Article'

    def index
    end

    def new
    end

    def edit
    end

    def create
      if @article.save
        redirect_to devx.articles_path,
        notice: "Successfully created #{@article}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @article.update(article_params)
        redirect_to devx.articles_path,
        notice: "Successfully updated #{@article}"
      else
        render :edit,
        notice: 'An error occurred'
      end
    end

    def destroy
      if @article.destroy
        redirect_to devx.articles_path,
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
      accessible = [ :title, :slug, :short_description, :content, :image, :published_at, :approved_at, :approved_by ]
      params.require(:article).permit(accessible)
    end
  end
end
