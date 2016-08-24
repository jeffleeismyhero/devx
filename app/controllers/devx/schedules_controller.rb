require_dependency "devx/application_controller"

module Devx
  class SchedulesController < ApplicationController
    load_resource :schedule, class: 'Devx::Schedule'
    load_resource :event, class: 'Devx::Event'
    load_resource :calendar, class: 'Devx::Calendar'

    layout :determine_layout

    def show
      if app_settings['calendar_layout'].present?
        @layout = Devx::Layout.find(app_settings['calendar_layout'])
      end

      @page = Devx::Page.new(name: @schedule.event.name, layout: @layout)
    end

    def export
      @schedule = Devx::Schedule.find(params[:id])

      respond_to do |format|
        format.ics do
          ical = Icalendar::Calendar.new

          if @schedule.start_time_date == @schedule.end_time_date
            multiday = false
          else
            multiday = true
          end

          if multiday == true && @schedule.all_day == false
            (@schedule.start_time_date..@schedule.end_time_date).try(:each) do |date|

              if @schedule.repeat == false || (@schedule.repeat == true && @schedule.days.include?(date.try(:strftime, '%A')) == true)
                event = Icalendar::Event.new

                event.dtstart = "#{date} #{@schedule.start_time_time}".to_datetime
                event.dtend = "#{date} #{@schedule.end_time_time}".to_datetime
                event.summary = @schedule.event.name
                event.description = @schedule.event.description

                ical.add_event(event)
              end
            end
          else
            event = Icalendar::Event.new

            event.dtstart = @schedule.start_time
            event.dtend = @schedule.end_time
            event.summary = @schedule.event.name
            event.description = @schedule.event.description

            ical.add_event(event)
          end

          render text: ical.to_ical
        end
      end
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
