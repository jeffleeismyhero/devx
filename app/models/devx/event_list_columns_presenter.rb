module Devx
  class EventListColumnsPresenter
    def self.for
      :event_list_columns
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
        calendar_type: calendar.calendar_type,
        limit: @attributes[:limit]
      }
    end


    private

    def calendar
      Devx::Calendar.find_by(id: @attributes[:id])
    end

    def get_events
      if calendar.calendar_type == 'Standard'
        calendar.upcoming_events.try(:limit, @attributes[:limit])
      else
        calendar.get_google_events.first(3)
      end
    end
  end
end