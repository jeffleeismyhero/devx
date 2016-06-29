require_dependency "devx/application_controller"

module Devx
  class Portal::RegistrationSubmissionsController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :registration_submission, class: 'Devx::RegistrationSubmission'
  	load_and_authorize_resource :registration, class: 'Devx::Registration'
  	layout 'devx/portal'

  	def show
  	end
  end
end
