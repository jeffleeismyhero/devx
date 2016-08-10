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
        limit: @attributes[:limit]
      }
    end


    private

    def calendar
      Devx::Calendar.find_by(id: @attributes[:id])
    end

    def get_events
      return Devx::Schedule.upcoming.ordered.try(:limit, @attributes[:limit])
    end
  end
end