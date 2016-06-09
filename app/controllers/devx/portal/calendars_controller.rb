require_dependency "devx/application_controller"

module Devx
  class Portal::CalendarsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :calendar, class: 'Devx::Calendar'
    layout 'devx/portal'

    def index
    end

    def show
        if @calendar.calendar_type == 'Google Calendar'
            @google_events = @calendar.get_google_events
        end
    end

    def new
    end

    def edit
    end

    def create
        if @calendar.valid? && @calendar.save
            redirect_to devx.portal_calendars_path,
            notice: "Successfully saved calendar"
        else
            render :new,
            notice: "Failed to save calendar"
        end
    end

    def update
        if @calendar.valid? && @calendar.update(calendar_params)
            redirect_to devx.portal_calendars_path,
            notice: "Successfully updated calendar"
        else
            render :edit,
            notice: "Failed to update calendar"
        end
    end

    def destroy
        if @calendar.destroy
            redirect_to devx.portal_calendars_path,
            notice: "Successfully deleted calendar"
        else
            redirect_to devx.portal_calendars_path,
            notice: "Failed to delete calendar"
        end
    end


    private

    def calendar_params
        accessible = [ :name, :calendar_type, :client_id, :client_secret, :google_calendar_id, :authorization_code, :time_zone, :active ]
        params.require(:calendar).permit(accessible)
    end
  end
end


