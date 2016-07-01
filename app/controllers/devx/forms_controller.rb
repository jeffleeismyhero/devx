require_dependency "devx/application_controller"

module Devx
  class FormsController < ApplicationController
    load_resource :form, class: 'Devx::Form'
    layout :determine_layout

    def show

      @page = Devx::Page.new(name: @form.name, layout: @form.layout)
    end

    def create

      @submission = Devx::FormSubmission.new(form_id: params[:form][:id], submission_content: params[:form][:submission_content])

      if @submission.valid? && @submission.save
        #@form.submission_recipients.split(',').try(:each) do |recipient|
          #Devx::NotificationMailer.delay.registration_completed(@registration, @submission, recipient)
        #end

        render devx.root_path,
        notice: 'Successfully submitted form'
      else
        render :show
      end

    end

    def determine_layout
      @form = Devx::Form.find(params[:id])

      if @form.layout.present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
