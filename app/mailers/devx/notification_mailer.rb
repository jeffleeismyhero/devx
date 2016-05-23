module Devx
  class NotificationMailer < ApplicationMailer
  	def signup(user)
  		@user = user

  		@subject = "Thanks for signing up"

  		mail to: @user.email, 
  		     subject: @subject
  	end

    def notify(user, subject, content)
      @user = user
      @subject = subject
      @content = content

      mail to: @user.email,
           subject: @subject
    end
  end
end
