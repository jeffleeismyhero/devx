module Devx
  class GeneralMailer < ApplicationMailer
    def send_message(recipient, subject, body)
      @recipient = recipient
      @subject = subject
      @body = body

      mail to: @recipient,
      subject: @subject,
      body: @body
    end
  end
end
