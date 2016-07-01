require_dependency "devx/application_controller"

module Devx
  class ContactController < ApplicationController
  	layout :determine_layout

  	def show
      if app_settings['contact_form_layout'].present?
        @layout = Devx::Layout.find(app_settings['calendar_layout'])
      end
      @page = Devx::Page.new(name: 'Contact Us', layout: @layout)

  		if request.post?
  			@contact = params[:contact]
  			
			if @contact.present?
  				Devx::ContactMailer.delay.submit_inquiry(@contact)
  			end
  		end
  	end

  	def determine_layout
  		if app_settings['contact_form_layout'].present?
  			'devx/custom'
  		else
  			'devx/application'
  		end
  	end
  end
end
