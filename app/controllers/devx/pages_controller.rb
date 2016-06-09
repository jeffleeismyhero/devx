require_dependency "devx/application_controller"

module Devx
  class PagesController < ApplicationController

    layout :set_layout

    def show
      if params[:id].present?
        @page = Devx::Page.find(params[:id])

        add_breadcrumb 'Home', :root_path

        if @page.parent.present?
          @parent = Devx::Page.find(@page.parent)
          add_breadcrumb @parent.name, @parent
        end

        add_breadcrumb @page.name

      else
        @page = Devx::Page.find_by(is_home: true)

        if @page.nil?
          @page = Devx::Page.create(name: 'Home', content: 'This is the default homepage for DevX', is_home: true)
        end
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
      return
    end

    def search
      @q = @pages.search(params[:q])
      @pages = @q.result
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
