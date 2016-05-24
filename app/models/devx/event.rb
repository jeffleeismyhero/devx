module Devx
  class Event < ActiveRecord::Base
    belongs_to :calendar
    belongs_to :venue

    scope :upcoming, -> { where("start_time > ?", Time.zone.now).order(start_time: :asc) }

    validates :name, presence: true
    validates :start_time, presence: true
  end
end
