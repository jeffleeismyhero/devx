require_dependency "Devx/application_controller"

module Devx
  class VenuesController < ApplicationController
    load_and_authorize_resource

    def index
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
      if @venue.valid? && @venue.save
        redirect_to venues_path,
        notice: "Successfully saved venue"
      else
        render :new,
        notice: "Failed to save venue"
      end
    end

    def update
      if @venue.valid? && @venue.save
        redirect_to venues_path,
        notice: "Successfully updated venue"
      else
        render :new,
        notice: "Failed to update venue"
      end
    end

    def destroy
      if @venue.destroy
        redirect_to venues_path
      end
    end


    private

    def venue_params
      accessible = [ :name, :address, :city, :state, :zip ]
      params.require(:venue).permit(accessible)
    end
  end
end
