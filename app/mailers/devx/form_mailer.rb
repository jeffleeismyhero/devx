module Devx
  class FormMailer < ApplicationMailer
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
          sanitized_field = field.gsub(/[^a-zA-Z0-9_-]/i, '')

          logger.debug "[FORM] Checking if #{sanitized_field} is key........#{@submission.key?(sanitized_field)}"

          if @submission.key?(sanitized_field)
            @field = @submission[sanitized_field.to_sym]

            logger.debug "[FORM] Replacing #{field} with #{@field}"
            
            @body.gsub!(field, @field)
          end
        end
      end

      mail to: @recipient,
      from: @from,
      subject: @subject
    end
  end
end
