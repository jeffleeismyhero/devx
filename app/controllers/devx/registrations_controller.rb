require_dependency "devx/application_controller"

module Devx
  class RegistrationsController < ApplicationController
    load_resource :registration, class: 'Devx::Registration'

    def show
    end

    def create
      @submission = Devx::RegistrationSubmission.new(registration_id: params[:registration][:id], submission_content: params[:registration][:submission_content])

      if @submission.valid? && @submission.save
        render plain: 'saved'
      else
        render :show
      end

    end
  end
end
