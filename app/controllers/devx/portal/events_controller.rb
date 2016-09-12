#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller"

module Devx
  class Portal::EventsController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
  	load_and_authorize_resource :event, class: 'Devx::Event'
  	load_and_authorize_resource :calendar, class: 'Devx::Calendar'

  	def index
      @events = @events.paginate(page: params[:page])
  	end

  	def show
  	end

  	def new
  	end

  	def edit
  	end

  	def create
      @event.calendar_id = @calendar.try(:id)

  		if @event.valid? && @event.save
  			redirect_to devx.edit_portal_calendar_event_path(@calendar, @event),
    			notice: "Successfully created event"
  		else
  			render :new, notice: "Failed to save event"
  		end
  	end

  	def update
      @event.calendar_id = @calendar.id

  		if @event.valid? && @event.update(event_params)
  			redirect_to devx.edit_portal_calendar_event_path(@calendar, @event),
  			   notice: "Successfully updated event"
  		else
  			render :edit, notice: "Failed to update event"
  		end
  	end

  	def destroy
  		if @event.destroy
  			redirect_to devx.portal_calendar_path(id: params[:calendar_id])
  		end
  	end

  	private

		def event_params
			accessible = [
        :name, :description, :start_time, :end_time, :location, :private,
        :contact_name, :contact_email, :venue_id, :tag_list,
        schedules_attributes: [
          :id, :start_time, :end_time, :start_time_date, :start_time_time,
          :end_time_date, :end_time_time, :all_day, :repeat, :_destroy, days: []
        ]
      ]
			params.require(:event).permit(accessible)
		end
  end
end
