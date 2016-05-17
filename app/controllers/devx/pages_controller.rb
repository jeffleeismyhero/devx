require_dependency "devx/application_controller"

module Devx
  class PagesController < ApplicationController

    layout :set_layout

    def show
      if params[:id].present?
        @page = Page.find(params[:id])
      else
        @page = Page.find_by(is_home: true)

        if @page.nil?
          @page = Page.create(name: 'Home', content: 'This is the default homepage for DevX', is_home: true)
        end
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
      return
    end


    private

    def set_layout
      if @page.layout.present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
