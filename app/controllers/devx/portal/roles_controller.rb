require_dependency "devx/application_controller"

module Devx
  class Portal::RolesController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :role, class: 'Devx::Role'
    layout 'devx/portal'

    def index
      @q = @roles.search(params[:q])
      @q.sorts = 'name asc'
      @roles = @q.result(distinct: true)
    end

    def edit
    end

    def new
    end

    def show
    end

    def create
      if @role.valid? && @role.save
        redirect_to devx.portal_roles_path,
        notice: "Successfully saved role"
      else
        render :new,
        notice: "Failed to save role"
      end
    end

    def update
      if @role.valid? && @role.save
        redirect_to devx.portal_roles_path,
        notice: "Successfully updated role"
      else
        render :edit,
        notice: "Failed to update role"
      end
    end

    def destroy
      if @role.destroy
        redirect_to devx.portal_roles_path,
        notice: "Successfully deleted role"
      else
        redirect_to devx.portal_roles_path,
        notice: "Failed to delete role"
      end
    end


    private

    def role_params
      accessible = [ :name ]
      params.require(:role).permit(accessible)
    end
  end
end
