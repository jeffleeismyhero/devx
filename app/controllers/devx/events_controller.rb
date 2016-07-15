require_dependency "devx/application_controller"

module Devx
  class EventsController < ApplicationController
    load_resource :event, class: 'Devx::Event'
    load_resource :calendar, class: 'Devx::Calendar'

    def show
      if app_settings['calendar_layout'].present?
        @layout = Devx::Layout.find(app_settings['calendar_layout'])
      end

      @page = Devx::Page.new(name: @event.name, layout: @layout)

    end

    def subscribe
      subscription = Devx::EventSubscription.new(event: @event, user: current_user)

      if subscription.valid? && subscription.save
        Devx::NotificationMailer.delay.subscription_confirmation(current_user, 'Event', @event)
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
