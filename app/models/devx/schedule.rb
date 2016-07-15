module Devx
  class Schedule < ActiveRecord::Base
    extend TimeSplitter::Accessors
    split_accessor :start_time
    split_accessor :end_time


    scope :upcoming, -> { where('start_time > ?', Time.zone.now).order(start_time: :asc) }
    scope :for_month, -> (start_time) { where('start_time >= ? AND start_time <= ?', start_time.beginning_of_month, start_time.end_of_month) }
    scope :ordered, -> { order(start_time: :asc) }

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

      return events
    end
  end
end
