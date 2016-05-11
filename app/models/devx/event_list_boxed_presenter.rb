module Devx
  class EventListBoxedPresenter
    def self.for
      :slideshow
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
      Devx::Event.upcoming.try(:limit, @attributes[:limit])
    end
  end
end