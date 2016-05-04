require_dependency "Devx/application_controller"

module Devx
  class PagesController < ApplicationController

    def show
      if params[:id].present?
        @page = Page.find(params[:id])
      else
        @page = Page.find_or_create_by(id: 1)
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
      return
    end
  end
end
