module Devx
  class Event < ActiveRecord::Base
    scope :upcoming, -> { where("start_time > ?", Time.zone.now).order(start_time: :asc) }
  end
end
