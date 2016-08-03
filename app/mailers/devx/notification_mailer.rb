module Devx
  class NotificationMailer < ApplicationMailer
  	def signup(user, password = nil)
  		@user = user
      @password = password
  		@subject = "Thanks for signing up"

  		mail to: @user.email, 
  		     subject: @subject
  	end

    def mychs(user, password)
      @user = user
      @subject = subject

      mail to: @user.email,
           subject: @subject
    end

    def mychs_reminder(subject, user)
      @user = user
      @subject = subject

      mail to: @user.email,
           subject: @subject
    end

    def form_submission(recipient, subject, submission)
      @recipient = recipient
      @subject = subject
      @submission = submission

      mail to: @recipient,
           subject: "Submission for #{@subject.name}"
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

    def registration_completed(registration, submission, recipient)
      @recipient = recipient
      @registration = registration
      @submission = submission
      @subject = "Registration completed for #{@registration.name}"

      mail to: @recipient,
        subject: @subject
    end
  end
end
