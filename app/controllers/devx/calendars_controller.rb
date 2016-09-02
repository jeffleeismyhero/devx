require_dependency "devx/application_controller"

module Devx
  class CalendarsController < ApplicationController
    load_resource :calendar, class: 'Devx::Calendar'
    layout :determine_layout

    def index
      if app_settings['calendar_layout'].present?
        @layout = Devx::Layout.find(app_settings['calendar_layout'])
      end

      @calendars = Devx::Calendar.active

      @q = @calendars.search(params[:q])
      puts @q.result.inspect
      @calendar = @q.result.first if @q.result.first.present?
      @tags = Devx::Event.tag_counts_on(:tags).order(name: :asc)


      if app_settings['default_calendar'].present?
        @calendar = Devx::Calendar.active.find(app_settings['default_calendar']) unless params[:q].present?
      end

      if !params['month_select'].blank? && !params['year_select'].blank?
        @start_date = "#{params['year_select']}-#{params['month_select']}-01".to_datetime
        params[:start_date] = @start_date
      else
        @start_date = params[:start_date].to_datetime unless params[:start_date].nil?
        @start_date ||= Time.zone.now
      end

      @page = Devx::Page.new(name: 'Calendar', layout: @layout)
      @dates = []

      (@start_date.beginning_of_month..@start_date.end_of_month).each do |date|
        @dates.push(date.to_date)
      end

      @events = Devx::Schedule.for_calendar(@calendar, @start_date)
      @schedules = Devx::Schedule.for_month(@start_date).ordered

      @scheduled_events = {}
      @dates.each do |date|
        @scheduled_events[date] = []
        @events.each do |event|
          event.schedules.ordered.try(:each_with_index) do |schedule, index|
            if schedule.end_time_date.present? && schedule.end_time_date >= date
              if schedule.start_time_date.present? && schedule.start_time_date <= date
                if !@scheduled_events[date].include?(schedule)
                  @scheduled_events[date].push(schedule)
                end
              end
            end
          end
        end
      end

      respond_to do |format|
        format.html
        format.ics do
          ical = Icalendar::Calendar.new

          Devx::Schedule.upcoming.try(:each) do |s|

            event = Icalendar::Event.new
            event.dtstart = s.start_time
            event.dtend = s.end_time
            event.summary = s.event.name
            event.description = s.event.description

            if params[:category].present?
              if s.event.tag_list.to_s == params[:category].to_s
                ical.add_event(event)
              end
            else
              ical.add_event(event)
            end
          end

          render text: ical.to_ical
        end
      end

    rescue => e
      logger.warn "[EXCEPTION] #{e.message}"
      logger.warn "[CALENDAR OBJECT] #{@calendar.inspect}"
      logger.warn "[CALENDAR INDEX OBJECT] #{@calendars.inspect}"
      logger.warn "[PARAMETERS] #{params.inspect}"
      redirect_to '/404.html'
    end

    def export_all
      respond_to do |format|
        format.ics do
          ical = Icalendar::Calendar.new

          Devx::Schedule.upcoming.try(:each) do |s|
            event = Icalendar::Event.new
            event.dtstart = s.start_time
            event.dtend = s.end_time
            event.summary = s.event.name
            event.description = s.event.description

            ical.add_event(event)
          end

          render text: ical.to_ical
        end
      end
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
