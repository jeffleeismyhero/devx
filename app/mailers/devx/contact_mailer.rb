module Devx
  class ContactMailer < ApplicationMailer
  	def submit_inquiry(contact, recipient = 'info@jcwproductions.com')
  		@contact = contact
  		@recipient = recipient

  		mail to: @recipient,
  		from: @contact['email'],
  		subject: 'Contact Form Submission'
  	end
  end
end
