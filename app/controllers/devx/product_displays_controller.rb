require_dependency "devx/application_controller"

module Devx
  class ProductDisplaysController < ApplicationController
  	before_action :set_product, only: [:show]
  	
  	def index
  		@products = Product.all
  	end

  	def show
  	end

  	private

  	def set_product
    	@product = Product.find(params[:id])
  	end
  end
end