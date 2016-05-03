#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller"

module Devx
  class Admin::EventsController < ApplicationController

  	#initializes instance variables. ( e.g. index uses @users = User.all, show uses @user = User.find(params[:id]) )
  	load_and_authorize_resources

  	def index
  	end

  	def show
  	end

  	def new
  	end

  	def edit
  	end

  	def create
  		if @event.valid? && event.save
  			redirect_to events_path,
  			notice: "Successfully created event"
  		else
  			render :new,
  			notice: "Failed to save event"
  		end
  	end

  	def update
  		if
  			@event.valid? && @event.update(event_params)
  			redirect_to events_path,
  			notice: "Successfully updated event"
  		else
  			render :new,
  			notice: "Failed to update event"
  		end
  	end

  	def destroy
  		if @event.destroy
  			redirect_to events_path
  		end
  	end

  	private

  		def event_params
  			accessible = [ :name, :description, :start_time, :end_time, :contact_name, :contact_email, :venue_id ]
  			params.require(:event).permit(accessible)
  		end

  end
end
