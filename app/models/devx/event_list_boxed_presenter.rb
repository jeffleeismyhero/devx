module Devx
  class EventListBoxedPresenter
    def self.for
      :event_list_boxed
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      {
        calendar: calendar,
        events: get_events,
        limit: @attributes[:limit]
      }
    end


    private

    def calendar
      Devx::Calendar.find_by(id: @attributes[:id])
    end

    def get_events
      events = Devx::Schedule.coming_up.ordered
      events = events.try(:limit, @attributes[:limit])
      events = events.sort_by{|s| s.start_time.strftime("%H%M") }
      events = events.try(:first, @attributes[:limit])
      return events
    end

  end
end
