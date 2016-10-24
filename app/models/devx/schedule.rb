module Devx
  class Schedule < ActiveRecord::Base
    def start_time_date
      start_time.try(:strftime, "%m/%d/%Y")
    end

    def start_time_time
      start_time.try(:strftime, "%I:%M %P")
    end

    def end_time_date
      end_time.try(:strftime, "%m/%d/%Y")
    end

    def end_time_time
      end_time.try(:strftime, "%I:%M %P")
    end

    def start_time_date=(value)
      self[:start_time] = Date.parse("#{value}")
    end

    def start_time_time=(value)
      self[:start_time] = DateTime.parse("#{self[:start_time].try(:strftime, "%m/%d/%Y")} #{value} #{Time.zone.name}")
      self[:start_time] -= 1.hour if self[:start_time].dst?
    end

    def end_time_date=(value)
      self[:end_time] = Date.parse("#{value}")
    end

    def end_time_time=(value)
      self[:end_time] = DateTime.parse("#{self[:end_time].try(:strftime, "%m/%d/%Y")} #{value} #{Time.zone.name}")
      self[:end_time] -= 1.hour if self[:end_time].dst?
    end

    acts_as_paranoid

    scope :upcoming, -> { where('(devx_schedules.start_time < ? OR devx_schedules.start_time >= ?) AND devx_schedules.end_time >= ?', Time.zone.now, Time.zone.now, Time.zone.now).ordered }
    scope :coming_up, -> { where('start_time >= ?', Time.zone.now).ordered }
    scope :for_month, -> (start_time) { where('start_time >= ? AND start_time <= ?', start_time.beginning_of_month, start_time.end_of_month).ordered }
    scope :ordered, -> { order("start_time ASC, end_time ASC") }
    scope :next, -> { joins(:event).where('devx_schedules.start_time > ?', Time.zone.now).first }

    belongs_to :event
    has_one :calendar, through: :event

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

    def is_future_occurrence?
      return true unless self.start_time < Time.zone.now
    end
  end
end
