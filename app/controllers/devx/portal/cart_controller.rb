require_dependency "devx/application_controller"

module Devx
	class Portal::CartController < ApplicationController
		load_and_authorize_resource :order, class: 'Devx::Order'
		layout 'devx/portal'

	  	def add
	  		id = params[:id]

	  		@sku = Devx::ProductSku.find(id)
	  		if @sku.present?

		  		#use the existing cart, otherwise if one doesn't exist then create a new cart
		  		if session[:cart] then
		  			cart = session[:cart]
		  		else
		  			session[:cart] = {}
		  			cart = session[:cart]
		  		end

		  		if cart[id] then
		  			cart[id] = cart[id] + 1
		  		else
		  			cart[id] = 1
		  		end
		  		redirect_to :action => :index

		  	end

		  	rescue ActiveRecord::RecordNotFound
		  		redirect_to :action => :index
	  	end

	  	def empty
	  		session[:cart] = nil
	   		redirect_to :action => :index
		end

	   def index
	    	if session[:cart] then
	    		@cart = session[:cart]
	    	else
	    		@cart = {}
	    	end
	   end

		 def checkout
			 if session[:cart]
				 @cart = session[:cart]
			 else
				 @cart = {}
			 end

			 @order = Devx::Order.new

			 if request.post?
				 if session[:cart]
					 @cart = session[:cart]
				 else
					 @cart = {}
				 end

				 line_items = []

				 if current_user.stripe_id.present?
					 customer = Stripe::Customer.retrieve(stripe_id)
				 else
					 customer = Stripe::Customer.create(email: current_user.email, source: params[:order][:stripe_token])
				 end

				 @cart.each do |line_item, quantity|
					 sku = Devx::ProductSku.find(line_item)
					 line_items << { type: 'sku', parent: sku.stripe_id, quantity: quantity, description: sku.product.name, amount: sku.price_in_cents }
				 end

				 Stripe::Order.create(
					currency: 'usd',
					customer: customer.id,
					items: line_items
				 )
			 end
		 end

	end
end
