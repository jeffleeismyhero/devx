require_dependency "devx/application_controller"

module Devx
  class Admin::CalendarsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :calendar, class: 'Devx::Calendar'
    layout 'devx/admin'

    def index
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
        if @calendar.valid? && @calendar.save
            redirect_to devx.admin_calendars_path,
            notice: "Successfully saved calendar"
        else
            render :new,
            notice: "Failed to save calendar"
        end
    end

    def update
        if @calendar.valid? && @calendar.update(calendar_params)
            redirect_to devx.admin_calendars_path,
            notice: "Successfully updated calendar"
        else
            render :edit,
            notice: "Failed to update calendar"
        end
    end

    def destroy
        if @calendar.destroy
            redirect_to devx.admin_calendars_path,
            notice: "Successfully deleted calendar"
        else
            redirect_to devx.admin_calendars_path,
            notice: "Failed to delete calendar"
        end
    end


    private

    def calendar_params
        accessible = [ :name, :active ]
        params.require(:calendar).permit(accessible)
    end
  end
end


