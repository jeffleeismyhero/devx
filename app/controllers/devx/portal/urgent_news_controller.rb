require_dependency "devx/application_controller"

module Devx
  class Portal::UrgentNewsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :urgent_news, class: 'Devx::UrgentNews'

    layout 'devx/portal'

    def index
    end

    def new
    end

    def edit
    end

    def show
    end

    def create
        if @urgent_news.save
            redirect_to portal_urgent_news_index_path
        else
            render :new
        end
    end

    def update
        if @urgent_news.update(urgent_news_params)
            redirect_to portal_urgent_news_index_path
        else
            render :edit
        end
    end

    def destroy
        if @urgent_news.destroy
            redirect_to portal_urgent_news_index_path
        end
    end

    private

    def urgent_news_params
        accessible = [:title, :message, :start_time, :end_time]
        params.require(:urgent_news).permit(accessible)
    end
  end
end
