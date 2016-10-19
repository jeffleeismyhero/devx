module Devx
  # Preview all emails at http://localhost:3000/rails/mailers/form_mailer
  class FormMailerPreview < ActionMailer::Preview
    def send_confirmation
      Devx::FormMailer.send_confirmation(Devx::Form.last, Devx::FormSubmission.last.submission_content, 'info@devxcms.com')
    end
  end
end
