require_dependency "devx/application_controller"

module Devx
  class Portal::MediaController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :medium, class: 'Devx::Medium'
    layout 'devx/portal'

    def index
    end


    def new
    end

    def create
      if @medium.valid? && @medium.save
        redirect_to devx.portal_media_path,
        notice: "Successfully saved media"
      else
        render :new,
        notice: "Failed to save media"
      end
    end

    def destroy
      if @medium.destroy
        redirect_to devx.portal_media_path,
        notice: "Successfully deleted media"
      else
        redirect_to devx.portal_media_path,
        notice: "Failed to delete media"
      end
    end


    private

    def medium_params
      accessible = [ :name, :file ]
      params.require(:medium).permit(accessible)
    end
  end
end
