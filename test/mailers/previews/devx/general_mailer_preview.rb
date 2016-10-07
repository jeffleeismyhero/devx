module Devx
  # Preview all emails at http://localhost:3000/rails/mailers/general_mailer
  class GeneralMailerPreview < ActionMailer::Preview
    def message
      Devx::GeneralMailer.message('rashaad@jcwproductions.com', 'Low Balance Notification', '<p>Hello Rashaad,</p><p>This is an alert that your account is now low.</p>'.html_safe)
    end
  end
end
