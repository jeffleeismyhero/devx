require_dependency "devx/application_controller"

module Devx
  class ArticlesController < ApplicationController
    load_resource :article, class: 'Devx::Article'
    layout :determine_layout

    def index
      if app_settings['newsfeed_layout'].present?
        @layout = Devx::Layout.find(app_settings['newsfeed_layout'])
      end

      @q = @articles.search(params[:q])
      @q.sorts = 'published_at desc'
      @articles = @q.result.published.latest.page(params[:page])
      @page = Devx::Page.new(name: 'News', layout: @layout)

      @tags = Devx::Article.tag_counts_on(:tags).order(name: :asc)
    end

    def show
      if app_settings['newsfeed_layout'].present?
        @layout = Devx::Layout.find(app_settings['article_layout'])
      end

      @page = Devx::Page.new(name: @article.title, layout: @layout)
    end

    def subscribe
      subscription = Devx::ArticleSubscription.new(category: @article.tag_list, user_id: params[:user])

      if subscription.valid? && subscription.save
        #Devx::NotificationMailer.subscription_confirmation(current_user, 'News Feed', @article)
        redirect_to devx.article_path(@article),
        notice: "You have subscribed to this news feed"
      else
        redirect_to devx.article_path(@article),
        notice: "You have already subscribed to this news feed"
      end
    end

    def page_name(value)
      value
    end

    def determine_layout
      if app_settings['newsfeed_layout'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
