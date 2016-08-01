module Devx
  class EventListTablePresenter
    def self.for
      :event_list_table
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
        category: @attributes[:category],
        limit: @attributes[:limit]
      }
    end


    private

    def calendar
      Devx::Calendar.find_by(id: @attributes[:id])
    end

    def get_events
      return Devx::Schedule.coming_up.try(:ordered).try(:limit, @attributes[:limit])
    end

  end
end