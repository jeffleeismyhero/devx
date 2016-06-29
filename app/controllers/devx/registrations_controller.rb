require_dependency "devx/application_controller"

module Devx
  class RegistrationsController < ApplicationController
    load_resource :registration, class: 'Devx::Registration'

    def show
    end

    def create
      @submission = Devx::RegistrationSubmission.new(registration_id: params[:registration][:id], submission_content: params[:registration][:submission_content])
      @registration = Devx::Registration.find(params[:registration][:id])

      if @submission.valid? && @submission.save
        @registration.submission_recipients.split(',').try(:each) do |recipient|
          Devx::NotificationMailer.delay.registration_completed(@registration, @submission, recipient)
        end

        render plain: 'saved'
      else
        render :show
      end

    end
  end
end
