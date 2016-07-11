require_dependency "devx/application_controller"

module Devx
  class FormsController < ApplicationController
    load_resource :form, class: 'Devx::Form'
    layout :determine_layout

    def show

      @page = Devx::Page.new(name: @form.name, layout: @form.layout)
    end

    def create
      @form = Devx::Form.find(params[:form][:id])
      @submission = Devx::FormSubmission.new(form_id: params[:form][:id], submission_content: params[:form][:submission_content])

      if @submission.valid? && @submission.save
        @form.submission_recipients.split(',').try(:each) do |recipient|
          Devx::NotificationMailer.delay.form_submission(recipient, @form, @submission.submission_content)
        end

        redirect_to devx.form_path(@form),
        notice: 'Successfully submitted form'
      else
        render :show,
        notice: 'An error occurred. Please check your submission and try again.'
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
