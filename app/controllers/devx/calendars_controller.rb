require_dependency "devx/application_controller"

module Devx
  class CalendarsController < ApplicationController
    load_resource :calendar, class: 'Devx::Calendar'
    layout :determine_layout

    def index
      if app_settings['newsfeed_layout'].present?
        @layout = Devx::Layout.find(app_settings['newsfeed_layout'])
      end

      @page = Devx::Page.new(name: 'Calendar', layout: @layout)

      @q = @calendars.active.search(params[:q])
      @calendar = @q.result.first
      @tags = Devx::Event.tag_counts_on(:tags).order(name: :asc)

      if app_settings['default_calendar'].present?
        @calendar = Devx::Calendar.active.find(app_settings['default_calendar']) unless params[:q].present?
      end


      if @calendar.calendar_type == 'Standard'
        @events = @calendar.events.for(Time.now, Time.now)

        @dates = []
        @events.try(:each) do |event|
          if !@dates.include?(event.start_time_date)
            @dates.push(event.start_time_date)
          end
        end     
      elsif @calendar.calendar_type == 'Google Calendar'
        @google_events = @calendar.get_google_events

        @a = []
        @google_events.try(:each) do |e|
          hash = { name: e.title, date: e.start_time.to_datetime.strftime('%Y-%m-%d'), start_time: e.start_time.to_datetime, end_time: e.end_time.to_datetime, venue: e.location }
          @a.push(hash)
        end

        @dates = []

        @a.map{ |x| x[:date] }.uniq.try(:each) do |event|
          @dates.push(event)
        end
      end

    # rescue
    #   redirect_to '/404.html'
    end

    def subscribe
      subscription = Devx::CalendarSubscription.new(calendar: @calendar, user: current_user)

      if subscription.valid? && subscription.save
        Devx::NotificationMailer.delay.subscription_confirmation(current_user, 'Calendar', @calendar)
        redirect_to devx.calendars_path,
        notice: "You have subscribed to this calendar"
      else
        redirect_to devx.calendars_path,
        notice: "You have already subscribed to this calendar"
      end
    end

    private


    def determine_layout
      if app_settings['newsfeed_layout'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
