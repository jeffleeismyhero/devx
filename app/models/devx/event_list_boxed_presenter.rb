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
      { events: events }
    end


    private

    def events
      Devx::Event.upcoming
    end
  end
end