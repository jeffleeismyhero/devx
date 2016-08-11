require_dependency "devx/application_controller"

module Devx
	class Portal::CartController < ApplicationController
		layout 'devx/portal'

	  	def add
	  		id = params[:id]

	  		@product = Devx::Product.find(id)
	  		if @product.present?

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

	end
end