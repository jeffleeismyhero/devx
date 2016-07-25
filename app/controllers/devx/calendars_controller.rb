require_dependency "devx/application_controller"

module Devx
  class CalendarsController < ApplicationController
    load_resource :calendar, class: 'Devx::Calendar'
    layout :determine_layout

    def index
      if app_settings['calendar_layout'].present?
        @layout = Devx::Layout.find(app_settings['calendar_layout'])
      end

      @q = @calendars.search(params[:q])
      @calendar = @q.result.first if @q.result.first.active == true
      @tags = Devx::Event.tag_counts_on(:tags).order(name: :asc)


      if app_settings['default_calendar'].present?
        @calendar = Devx::Calendar.active.find(app_settings['default_calendar']) unless params[:q].present?
      end

      if !params['month_select'].blank? && !params['year_select'].blank?
        @start_date = "#{params['year_select']}-#{params['month_select']}-01".to_datetime
        params[:start_date] = @start_date
      else
        @start_date = params[:start_date].to_datetime unless params[:start_date].nil?
        @start_date ||= DateTime.now
      end
      
      @page = Devx::Page.new(name: 'Calendar', layout: @layout)
      @dates = []

      (@start_date.beginning_of_month..@start_date.end_of_month).each do |date|
        @dates.push(date.to_date)
      end

      if @calendar.calendar_type.present?# == 'Standard'
        @events = Devx::Schedule.for_calendar(@calendar, @start_date)
        @schedules = Devx::Schedule.for_month(@start_date)


        @years = []

        Devx::Schedule.all.ordered.try(:each) do |s|
          if !@years.include?(s.start_time.try(:strftime, '%Y'))
            @years.push(s.start_time.try(:strftime, '%Y'))
          end
        end

        @scheduled_events = {}
        @dates.each do |date|
          @scheduled_events[date] = []
          @events.each do |event|
            event.schedules.each_with_index do |schedule, index|
              if schedule.end_time_date >= date
                if schedule.start_time_date <= date
                  if !@scheduled_events[date].include?(schedule)
                    @scheduled_events[date].push(schedule)
                  end
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

      # if @calendar.calendar_type == 'Standard'
      #   @events = Devx::Schedule.for_calendar(@calendar)


      #   # render plain: Devx::Schedule.for_calendar(@calendar).inspect
      #   # return

      #   @events.try(:each) do |event|
      #     event.schedules.try(:each) do |schedule|
      #       if !@dates.include?(schedule.start_time_date)
      #         @dates.push(schedule.start_time_date)
      #       end
      #     end
      #   end     
      # elsif @calendar.calendar_type == 'Google Calendar'
      #   @google_events = @calendar.get_google_events

      #   @a = []
      #   @google_events.try(:each) do |e|
      #     hash = { name: e.title, date: e.start_time.to_datetime.strftime('%Y-%m-%d'), start_time: e.start_time.to_datetime, end_time: e.end_time.to_datetime, venue: e.location }
      #     @a.push(hash)
      #   end

      #   @a.map{ |x| x[:date] }.uniq.try(:each) do |event|
      #     @dates.push(event)
      #   end
      # end

      # render plain: @dates.inspect
      # return

    # rescue
    #   redirect_to '/404.html'
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
