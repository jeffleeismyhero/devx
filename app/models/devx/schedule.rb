module Devx
  class Schedule < ActiveRecord::Base
    extend TimeSplitter::Accessors
    split_accessor :start_time, date_format: "%m/%d/%Y", time_format: "%I:%M %P"
    split_accessor :end_time, date_format: "%m/%d/%Y", time_format: "%I:%M %P"

    acts_as_paranoid

    scope :upcoming, -> { where('(start_time < ? OR start_time >= ?) AND end_time >= ?', Time.zone.now, Time.zone.now, Time.zone.now).ordered }
    scope :coming_up, -> { where('start_time >= ?', Time.zone.now).ordered }
    scope :for_month, -> (start_time) { where('start_time >= ? AND start_time <= ?', start_time.beginning_of_month, start_time.end_of_month).ordered }
    scope :ordered, -> { order("start_time ASC, end_time ASC") }

    belongs_to :event

    validates :start_time, presence: true, uniqueness: { scope: [ :event_id ] }
    #validates :event, presence: true

    def self.per_page
      10
    end

    def self.for_calendar(calendar, start_time = Time.zone.now)
      events = []
      self.for_month(start_time).ordered.each do |s|
        if s.event.calendar == calendar
          events.push(s.event)
        end
      end
      events
    end

    def self.resequence(calendar, schedules, date)
      schedules = schedules.joins(:event).where('devx_events.calendar_id': calendar.id)
      schedules.collect do |schedule|
        current_date = date
        next_occurrence = nil
        days = schedule.days.reject(&:blank?)
        if days.any?
          day_indexes = days.collect{ |d| Date::DAYNAMES.index(d) }
          current_day = current_date.strftime("%A")
          current_day_index = Date::DAYNAMES.index(current_day)
          until next_occurrence
            if day_indexes.index(current_day_index)
              next_occurrence = current_date
            else
              current_day_index = (current_day_index + 1 > 6) ? 0 : current_day_index + 1
              current_date = current_date + 1.day
            end
          end
        else
          next_occurrence = current_date
        end

        if schedule.start_time.to_date < next_occurrence
          advance = (next_occurrence - schedule.start_time.to_date).to_i
          schedule.start_time = schedule.start_time.advance(days: advance)
        end

        # Do not return any schedules where the next time would be past the
        # `end_time` value.
        (schedule.end_time && (schedule.start_time < schedule.end_time)) ? schedule : nil
      end.compact
    end
  end
end
