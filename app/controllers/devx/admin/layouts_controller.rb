require_dependency "devx/application_controller"

module Devx
  class Admin::LayoutsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :layout, class: 'Devx::Layout'
    layout 'devx/admin'

    def index
    end

    def edit
    end

    def new
    end

    def create
      if @layout.valid? && @layout.save
        redirect_to devx.edit_admin_layout_path(@layout),
        notice: "Successfully saved layout"
      else
        render :new,
        notice: "Failed to save layout"
      end
    end

    def update
      if @layout.valid? && @layout.update(layout_params)
        redirect_to devx.edit_admin_layout_path(@layout),
        notice: "Successfully updated layout"
      else
        render :new,
        notice: "Failed to update layout"
      end
    end

    def destroy
      if @layout.destroy
        redirect_to devx.admin_layouts_path,
        notice: "Successfully deleted layout"
      else
        redirect_to devx.admin_layouts_path,
        notice: "Failed to delete layout"
      end
    end


    private

    def layout_params
      accessible = [ :name, :content, stylesheet_ids: [] ]
      params.require(:layout).permit(accessible)
    end
  end
end
