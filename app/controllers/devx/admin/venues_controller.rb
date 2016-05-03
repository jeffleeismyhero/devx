#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller" 

module Devx
  class Admin::VenuesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/admin'
  	#initializes instance variables. ( e.g. index uses @venues = Venue.all, show uses @venue = Venue.find(params[:id]) )
  	load_and_authorize_resource

  	def index
  	end

  	def show
  	end

  	def new
  	end

  	def edit
  	end

  	def create
  		if @venue.valid? && @venue.save
  			redirect_to devx.venues_path,
  			notice: "Successfully saved venue"
  		else
  			render :new,
  			notice: "Failed to save venue"
  		end
  	end

  	def update
  		if @venue.valid? && @venue.save
  			redirect_to devx.venues_path,
  			notice: "Successfully saved venue"
  		else
  			render :new,
  			notice: "Failed to save venue"
  		end
  	end

  	def destroy
  		if @venue.destroy
  			redirect_to devx.venues_path
  		end
  	end

  	private

  		def venue_params
  			accessible = [ :name, :address, :city, :state, :zip ].
  			params.require(:venue).permit(accessible)
  		end
  		
  end
end
