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
          sanitized_field = field.gsub!(/[^a-zA-Z0-9_-]/i, '')
          logger.debug "Sanitized #{sanitized_field}"

          logger.debug "[FORM] Checking if #{sanitized_field} is key........#{@submission.key?(sanitized_field)}"

          if @submission.key?(sanitized_field)
            @field = @submission[sanitized_field.to_sym]
            if sanitized_field == 'Amount'
              @field = number_to_currency @field
            end

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


Thank you for your gift to Rosarian Academy for [amount]. \n\nGiving opens precious doors of opportunity and keeps Rosarian in the forefront of teaching and learning. Whether you are supporting the day-to-day life of our students and faculty or long-term plans to keep our school viable and competitive, your gift is used carefully and invested wisely. \n\nYour Donation Details:\n\nDonation Type: [name]\n\n\nFor questions pertaining to your gift or future gifts, please contact the Advancement Office:\n561-345-3109 or advancement@rosarian.org.\n\nThank you for believing in the mission of Rosarian Academy!
