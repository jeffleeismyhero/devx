require_dependency "devx/application_controller"

module Devx
  class Portal::PagesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :page, class: 'Devx::Page', except: :show

    def index
    end

    def new
    end

    def edit
    end

    def create
      if @page.valid? && @page.save
        redirect_to devx.edit_portal_page_path(@page),
        notice: "Successfully saved page"
      else
        render :new,
        notice: "Failed to save page"
      end
    end

    def update
      if @page.valid? && @page.update(page_params)
        redirect_to devx.edit_portal_page_path(@page),
        notice: "Successfully updated page"
      else
        render :edit,
        notice: "Failed to save page"
      end
    end

    def destroy
      if @page.destroy
        redirect_to devx.portal_pages_path,
        notice: "Successfully deleted page"
      end
    end


    private

    def page_params
      accessible = [ :name, :content, :layout_id, :parent, :image, :active, :is_home ]
      params.require(:page).permit(accessible)
    end
  end
end
