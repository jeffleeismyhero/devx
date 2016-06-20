require_dependency "devx/application_controller"

module Devx
  class CalendarsController < ApplicationController
    load_resource :calendar, class: 'Devx::Calendar'

    def index
    end

    def show
    end

    def subscribe
      subscription = Devx::CalendarSubscription.new(calendar: @calendar, user: current_user)

      if subscription.valid? && subscription.save
        redirect_to devx.calendar_path(@calendar),
        notice: "You have subscribed to this calendar"
      else
        redirect_to devx.calendar_path(@calendar),
        notice: "You have already subscribed to this calendar"
      end
    end
  end
end
