module Devx
  class Calendar < ActiveRecord::Base
    has_many :events

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    def upcoming_events
      self.events.where("start_time > ?", Time.zone.now).order(start_time: :asc)
    end
  end
end
