require_dependency "devx/application_controller"

module Devx
  class EventsController < ApplicationController
    load_resource :event, class: 'Devx::Event'
    load_resource :calendar, class: 'Devx::Calendar'

    def show
    end

    def subscribe
      subscription = Devx::EventSubscription.new(event: @event, user: current_user)

      if subscription.valid? && subscription.save
        Devx::NotificationMailer.subscription_confirmation(current_user, 'Event', @event)
        redirect_to devx.calendar_event_path(@calendar, @event),
        notice: "You have subscribed to this event"
      else
        redirect_to devx.calendar_event_path(@calendar, @event),
        notice: "You have already subscribed to this event"
      end
    end


    private

    def event_params
      accessible = [ :name, :description, :start_time, :end_time, :contact_name, :contact_email, :venue_id ]
      params.require(:event).permit(accessible)
    end
  end
end
