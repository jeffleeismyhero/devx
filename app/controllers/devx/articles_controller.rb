require_dependency "devx/application_controller"

module Devx
  class ArticlesController < ApplicationController
    load_resource :article, class: 'Devx::Article'

    def index
      @articles = @articles.page(params[:page])
    end

    def show
    end

    def subscribe
      subscription = Devx::ArticleSubscription.new(category: @article.tag_list, user: current_user)

      if subscription.valid? && subscription.save
        Devx::NotificationMailer.subscription_confirmation(current_user, 'News Feed', @article)
        redirect_to devx.article_path(@article),
        notice: "You have subscribed to this news feed"
      else
        redirect_to devx.article_path(@article),
        notice: "You have already subscribed to this news feed"
      end
    end
  end
end
