require_dependency "devx/application_controller"

module Devx
  class Portal::PagesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :page, class: 'Devx::Page', except: :show

    def index
      @q = @pages.search(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @pages = @q.result(distinct: true)
      
      respond_to do |format|
        format.html
        format.xlsx do
          render xlsx: 'index', filename: 'pages_export.xlsx'
        end
      end
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
        notice: "Successfully deleted the page."
      else
        redirect_to devx.portal_pages_path,
        notice: "Failed to delete the page."
      end
    end

    def import
      
    end


    private

    def page_params
      accessible = [ :name, :content, :layout_id, :parent, :image, :active, :is_home, :meta_title, :meta_description,
                    meta_keyword_list: [], meta_robot_list: [] ]
      params.require(:page).permit(accessible)
    end
  end
end
