#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller" 

module Devx
  class Portal::VenuesController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
  	#initializes instance variables. ( e.g. index uses @venues = Venue.all, show uses @venue = Venue.find(params[:id]) )
  	load_and_authorize_resource :venue, class: 'Devx::Venue'

  	def index
      @q = @venues.search(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @venues = @q.result(distinct: true)
  	end

  	def show
  	end

  	def new
  	end

  	def edit
  	end

  	def create
  		if @venue.valid? && @venue.save
  			redirect_to devx.portal_venues_path,
  			notice: "Successfully saved venue"
  		else
  			render :new,
  			notice: "Failed to save venue"
  		end
  	end

  	def update
  		if @venue.valid? && @venue.save
  			redirect_to devx.portal_venues_path,
  			notice: "Successfully saved venue"
  		else
  			render :new,
  			notice: "Failed to save venue"
  		end
  	end

  	def destroy
  		if @venue.destroy
  			redirect_to devx.portal_venues_path
  		end
  	end

  	private

  		def venue_params
  			accessible = [ :name, :address, :city, :state, :zip ]
  			params.require(:venue).permit(accessible)
  		end
  		
  end
end
