module Devx
  class FormMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)

    def send_confirmation(form, submission, recipient)
      @form = form
      @submission = submission
      @body = @form.confirmation_email_text
      @from = @form.confirmation_email_from
      @subject = @form.confirmation_email_subject
      @recipient = recipient
      @fields = @body.scan(/\[.*?\]/)

      if @fields.any?
        @fields.each_with_index do |field, index|
          logger.debug "[FORM] Sanitizing #{field}"
          sanitized_field = field.gsub(/[^a-zA-Z0-9 \_\-\(\)\'\"\#\$]/i, '')
          logger.debug "[FORM] Sanitized #{sanitized_field}"

          logger.debug "[FORM] Checking if #{sanitized_field} is key........#{@submission.key?(sanitized_field)}"

          if @submission.key?(sanitized_field)
            @field = @submission[sanitized_field.to_s]

            logger.debug "[FORM] Replacing #{field} with #{@field}"

            @body.gsub!(field, @field.to_s)
          end
        end
      end

      mail to: @recipient,
      from: @from,
      subject: @subject
    end
  end
end
