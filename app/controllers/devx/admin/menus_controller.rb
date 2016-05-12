require_dependency "devx/application_controller"

module Devx
  class Admin::MenusController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :menu, class: 'Devx::Menu'
    layout 'devx/admin'

    def index
    end

    def edit
    end

    def new
    end

    def create
      if @menu.valid? && @menu.save
        redirect_to devx.edit_admin_menu_path(@menu),
        notice: "Successfully saved menu"
      else
        render :new,
        notice: "Failed to save menu"
      end
    end

    def update
      if @menu.valid? && @menu.update(menu_params)
        

        if !@menu.add(Page.find(params[:menu][:page_ids]))
          redirect_to devx.edit_admin_menu_path
          puts "Page already exists in the menu"
        end

        redirect_to devx.edit_admin_menu_path(@menu),
        notice: "Successfully updated menu"
      else
        render :edit,
        notice: "Failed to update menu"
      end
    end

    def destroy
      if @menu.destroy
        redirect_to devx.admin_menus_path,
        notice: "Successfully deleted menu"
      else
        redirect_to devx.admin_menus_path,
        notice: "Failed to delete menu"
      end
    end


    private

    def menu_params
      accessible = [ :name ]
      params.require(:menu).permit(accessible)
    end
  end
end
