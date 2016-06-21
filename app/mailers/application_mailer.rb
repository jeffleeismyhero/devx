class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{request.domain}"
  layout 'mailer'
end
