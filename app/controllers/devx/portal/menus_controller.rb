require_dependency "devx/application_controller"

module Devx
  class Portal::MenusController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :menu, class: 'Devx::Menu'
    layout 'devx/portal'

    def index
      @q = @menus.search(params[:q])
      @q.sorts = 'name asc'
      @menus = @q.result(distinct: true)
    end

    def edit
    end

    def new
    end

    def create
      if @menu.valid? && @menu.save
        redirect_to devx.edit_portal_menu_path(@menu),
        notice: "Successfully saved menu"
      else
        render :new,
        notice: "Failed to save menu"
      end
    end

    def update
      if @menu.valid? && @menu.update(menu_params)
        render plain: @menu.add(Devx::Page.find(params[:page][:id]))
        return

        if !@menu.add(Devx::Page.find(params[:page][:id]))
          redirect_to devx.edit_portal_menu_path,
          notice: "Page already exists in the menu"
          return
        end

        redirect_to devx.edit_portal_menu_path(@menu),
        notice: "Successfully updated menu"
      else
        render :edit,
        notice: "Failed to update menu"
      end
    end

    def destroy
      if @menu.destroy
        redirect_to devx.portal_menus_path,
        notice: "Successfully deleted menu"
      else
        redirect_to devx.portal_menus_path,
        notice: "Failed to delete menu"
      end
    end

    def sort
      list = params[:menu_page] || params[:page]
      list.each_with_index do |id, index|
        Devx::MenuPage.find(id).update_columns(position: index + 1)
      end
      render nothing: true
    rescue
    end


    private

    def menu_params
      accessible = [ :name ]
      params.require(:menu).permit(accessible)
    end
  end
end
