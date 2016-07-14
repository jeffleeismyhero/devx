module Devx
  class Schedule < ActiveRecord::Base
    extend TimeSplitter::Accessors
    split_accessor :start_time
    split_accessor :end_time


    scope :upcoming, -> { where('start_time > ?', Time.zone.now).order(start_time: :asc) }

    belongs_to :event

    def self.for_calendar(calendar)
      events = []
      self.all.each do |s|
        if s.event.calendar == calendar
          events.push(s.event)
        end
      end

      return events
    end
  end
end
