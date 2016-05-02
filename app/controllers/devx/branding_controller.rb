require_dependency "Devx/application_controller"

module Devx
  class BrandingController < ApplicationController
    load_and_authorize_resource

    def index
      @branding = Branding.find_or_create_by(id: 1)
    end

    def update
      if @branding.valid? && @branding.update(branding_params)
        redirect_to branding_index_path,
        notice: "Saved"
      else
        redirect_to branding_index_path,
        notice: "Failed to save"
      end
    end


    private

    def branding_params
      accessible = [ :company_name, :logo ]
      params.require(:branding).permit(accessible)
    end
  end
end
