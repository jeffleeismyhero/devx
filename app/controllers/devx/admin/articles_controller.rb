require_dependency "Devx/application_controller"

module Devx
  class Admin::ArticlesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/admin'
    load_and_authorize_resource :article, class: 'Devx::Article'

    def index
    end

    def new
    end

    def edit
    end

    def create
      if @article.save
        redirect_to devx.admin_articles_path,
        notice: "Successfully created #{@article}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @article.update(article_params)
        redirect_to devx.admin_articles_path,
        notice: "Successfully updated #{@article}"
      else
        render :edit,
        notice: 'An error occurred'
      end
    end

    def destroy
      if @article.destroy
        redirect_to devx.admin_articles_path,
        notice: "Successfully deleted #{@article.title}"
      else
        render :index,
        notice: 'An error occurred'
      end
    end


    private

    def article_params
      accessible = [ :title, :slug, :short_description, :content, :image, :published_at ]
      params.require(:article).permit(accessible)
    end
  end
end
