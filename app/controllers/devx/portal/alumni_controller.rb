require_dependency "devx/application_controller"

module Devx
  class Portal::AlumniController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :alumni, class: 'Devx::Alumni'
    layout 'devx/portal'

    def index
    end

    def show
    end

    def edit
    end

    def new
    end

    def create
      if @alumni.valid? && @alumni.save
        redirect_to devx.portal_alumni_index_path,
        notice: "Successfully saved alumni"
      else
        render :new,
        notice: "Failed to save alumni"
      end
    end

    def update
      if @alumni.valid? && @alumni.save
        redirect_to devx.portal_alumni_index_path,
        notice: "Successfully updated alumni"
      else
        render :new,
        notice: "Failed to update alumni"
      end
    end

    def destroy
      if @alumni.destroy
        redirect_to devx.portal_alumni_index_path,
        notice: "Successfully deleted alumni"
      else
        redirect_to devx.portal_alumni_index_path,
        notice: "Failed to delete alumni"
      end
    end


    private

    def alumni_params
      accessible = [ :prefix, :first_name, :last_name, :suffix, :nickname, :marital_status, :birthdate, :graduation_year, :address, :city, :state, :zip, :email, :phone, :linked_in ]
      params.require(:alumni).permit(accessible)
    end
  end
end
