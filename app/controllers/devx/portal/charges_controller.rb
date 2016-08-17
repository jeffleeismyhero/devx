require_dependency "devx/application_controller"

module Devx
  class Portal::ChargesController < ApplicationController
  	layout 'devx/portal'

  	def new
  	end

  	def create
  		@amount = 2500 #amount in cents

  		customer = Stripe::Customer.create(
  			:email => 'customer@jcwproductions.com', 
  			:card => params[:stripeToken])
  		
  		charge = Stripe::Charge.create(
  			:customer => customer.id, 
  			:amount => @amount, 
  			:description => 'JCW Customer', 
  			:currency => 'usd')

  		rescue Stripe::CardError => e
  			flash[:error] = e.message
  			redirect_to new_charge_path
  	end

  end
end