require_dependency "devx/application_controller"

module Devx
  class FormsController < ApplicationController
    load_resource :form, class: 'Devx::Form'
    layout :determine_layout, except: :create

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
          price += sanitize_currency(field.options.to_f * @submission.submission_content[field.name])
        end
      elsif @submission.submission_content['fee'].present?
        price += sanitize_currency(@submission.submission_content['fee'])
      elsif params['amount'].present?
        price = sanitize_currency(params['amount'])
      end

      logger.debug "[DONATE] #{params['ch_first_name']} #{params['ch_last_name']} - AMOUNT: #{params['amount']} --- PRICE: #{price}".squish

      if price > 0
        payment_details = {
          amount: price,
          credit_card_type: params['cc_type'],
          credit_card_number: params['cc_number'],
          credit_card_expiration: ("%02d%02d" % [params['expiry_date(2i)'], params['expiry_date(1i)'].last(2)]),
          credit_card_cvv: params['cvv'],
          customer_first_name: params['ch_first_name'],
          customer_last_name: params['ch_last_name'],
          customer_zip_code: params['zip_code']
        }

        @submission.submission_content['Amount'.to_sym] = payment_details[:amount]
        @submission.submission_content['Credit Card Type'.to_sym] = payment_details[:credit_card_type]
      end

      if @submission.valid?
        if price > 0
          if response = Devx::PaymentProcessor.process(@form, @submission, payment_details, request.env["HTTP_X_FORWARDED_FOR"])
            purchase_successful = true
          else
            purchase_successful = false
          end
        end

        if ((price > 0 && purchase_successful == true) || price.zero?) && @submission.save
          @form.submission_recipients.split(',').try(:each) do |recipient|
            Devx::NotificationMailer.delay.form_submission(recipient, @form, @submission.submission_content)
          end

          if @form.fields.where(field_type: 'email_field').any?
            Devx::FormMailer.delay.send_confirmation(@form, @submission.submission_content, @form.fields.where(field_type: 'email_field').first)

          end

          notice = @form.success_message
          if notice.nil?
            notice = "Successfully submitted form"
          end

          redirect_to devx.form_path(@form),
          notice: notice
        else
          render :show,
          notice: 'There was a problem processing your payment. Please try again.'
        end
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


    private

    def sanitize_currency(value)
      value.to_s.gsub(/[^\.\d]/, '').to_f
    end
  end
end
