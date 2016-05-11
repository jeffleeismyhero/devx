module Devx
  class Event < ActiveRecord::Base

    belongs_to :venue

    scope :upcoming, -> { where("start_time > ?", Time.zone.now).order(start_time: :asc) }
  end
end
