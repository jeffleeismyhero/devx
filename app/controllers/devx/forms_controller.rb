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

      purchase_fields = []
      @form.fields.try(:each) do |field|
        if field.field_type == 'purchase_field'
          purchase_fields << field
        end
      end

      price = 0
      if purchase_fields.any?
        purchase_fields.try(:each) do |field|
          price += (field.options.to_f * @submission.submission_content[field.name].to_f)
        end

        exp_date = "%02d%02d" % [params['expiry_date(2i)'], params['expiry_date(1i)'].last(2)]
        if response = Devx::PaymentProcessor.process(@form, @submission, price, params['ch_first_name'], params['ch_last_name'], params['cc_number'], exp_date, params['cvv'], request.env["HTTP_X_FORWARDED_FOR"])
          purchase_successful = true
        else
          purchase_successful = false
        end

        if purchase_successful == false
          render :show,
          notice: 'An error occurred. Please check your submission and try again.'
        end
      end

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
