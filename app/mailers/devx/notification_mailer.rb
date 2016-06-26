module Devx
  class NotificationMailer < ApplicationMailer
  	def signup(user, password = nil)
  		@user = user
      @password = password
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

    def subscription_confirmation(user, type, object)
      @user = user
      @object = object
      @type = type
      @subject = "#{@type} Subscription"

      if @type == 'Article'
        @object.name = object.title
      end

      mail to: @user.email,
        subject: @subject
    end

    def registration_completed(user, registration)
      @user = user
      @registration = registration
      @subject = "Registration completed for #{@registation.name}"

      mail to: @user.email,
        subject: @subject
    end
  end
end
