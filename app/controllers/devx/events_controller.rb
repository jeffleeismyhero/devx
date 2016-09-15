require_dependency "devx/application_controller"

module Devx
  class EventsController < ApplicationController
    load_resource :event, class: 'Devx::Event'
    load_resource :calendar, class: 'Devx::Calendar'

    layout :determine_layout

    def subscribe
      subscription = Devx::EventSubscription.new(event: @event, user: current_user)

      if subscription.valid? && subscription.save
        Devx::NotificationMailer.delay.subscription_confirmation(current_user, 'Event', @event)
        redirect_to devx.portal_dashboard_path(@calendar, @event, subdomain: 'portal'),
        notice: "You have subscribed to this event"
      else
        redirect_to devx.portal_dashboard_path(@calendar, @event, subdomain: 'portal'),
        notice: "You have already subscribed to this event"
      end
    end

    def unsubscribe
      subscribe = Devx::EventSubscription.find_by(event: @event, user: current_user)

      if subscribe.present?
        subscribe.destroy
      end

      redirect_to devx.portal_dashboard_path(subdomain: 'portal')
    end


    private

    def determine_layout
      if app_settings['calendar_layout'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
