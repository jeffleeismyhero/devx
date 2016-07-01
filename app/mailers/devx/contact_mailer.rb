module Devx
  class ContactMailer < ApplicationMailer
  	def submit_inquiry(contact, recipient = 'cara@rosarian.org')
  		@contact = contact
  		@recipient = recipient

  		mail to: @recipient,
  		from: @contact['email'],
  		subject: 'Contact Form Submission'
  	end
  end
end
