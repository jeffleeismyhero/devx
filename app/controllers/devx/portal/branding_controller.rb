#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller"

module Devx
  class Portal::BrandingController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    #initializes instance variables. ( e.g. index uses @users = User.all, show uses @user = User.find(params[:id]) )
    load_and_authorize_resource :branding, class: 'Devx::Branding'

  def index
  	@branding = Branding.find_or_create_by(id: 1)
  end

  def update
  	if @branding.valid? && @branding.update(branding_params)
  		redirect_to devx.portal_branding_index_path,
  		notice: "Saved"

  	else
  		redirect_to devx.portal_branding_index_path,
  		notice: "Failed to save"
  	end
  end

  	private

  		def branding_params
  			accessible = [ :company_name, :logo, :alternate_logo, :favicon, :primary_color, :secondary_color, :accent_color_1, :accent_color_2, :accent_color_3 ]
  			params.require(:branding).permit(accessible)
  		end

  end
end
