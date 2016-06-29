require_dependency "devx/application_controller"

module Devx
  class FormsController < ApplicationController
    load_resource :form, class: 'Devx::Form'

    def show
    end

    def create

      @submission = Devx::FormSubmission.new(form_id: params[:form][:id], submission_content: params[:form][:submission_content])

      if @submission.valid? && @submission.save
        #@form.submission_recipients.split(',').try(:each) do |recipient|
          #Devx::NotificationMailer.delay.registration_completed(@registration, @submission, recipient)
        #end

        render plain: 'saved'
      else
        render :show
      end

    end
  end
end
