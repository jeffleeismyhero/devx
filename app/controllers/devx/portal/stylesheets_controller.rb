require_dependency "devx/application_controller"

module Devx
  class Portal::StylesheetsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :stylesheet, class: 'Devx::Stylesheet'
    layout 'devx/portal'

    def index
      @q = @stylesheets.search(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @stylesheets = @q.result(distinct: true)
    end

    def edit
    end

    def new
    end

    def create
      if @stylesheet.valid? && @stylesheet.save
        redirect_to devx.edit_portal_stylesheet_path(@stylesheet),
        notice: "Successfully saved stylesheet"
      else
        redirect_to devx.edit_portal_stylesheet_path(@stylesheet),
        notice: "Failed to save stylesheet"
      end
    end

    def update
      if @stylesheet.valid? && @stylesheet.update(stylesheet_params)
        redirect_to devx.edit_portal_stylesheet_path(@stylesheet),
        notice: "Successfully updated stylesheet"
      else
        redirect_to devx.edit_portal_stylesheet_path(@stylesheet),
        notice: "Failed to update stylesheet"
      end
    end

    def destroy
      if @stylesheet.destroy
        redirect_to devx.portal_stylesheets_path,
        notice: "Successfully deleted stylesheet"
      else
        redirect_to devx.portal_stylesheets_path,
        notice: "Failed to delete stylesheet"
      end
    end


    private

    def stylesheet_params
      accessible = [ :name, :content ]
      params.require(:stylesheet).permit(accessible)
    end
  end
end
