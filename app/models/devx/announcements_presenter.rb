module Devx
  class AnnouncementsPresenter
    def self.for
      :announcements
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { announcements: announcements }
    end


    private

    def announcements
      Devx::Announcement.all.order(created_at: :desc).first(2)
    end
  end
end