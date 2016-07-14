module Devx
  class Event < ActiveRecord::Base
    acts_as_taggable

    has_many :event_subscriptions
    has_many :schedules
    belongs_to :calendar
    belongs_to :venue

    scope :upcoming, -> { where("start_time > ?", Time.zone.now).order(start_time: :asc) }
    scope :for, -> (start_time, end_time) { where('start_time > ? AND start_time < ?', start_time.beginning_of_month, end_time.end_of_month) }
    scope :uniq_dates, -> { uniq.pluck(:start_time) }

    validates :name, presence: true

    accepts_nested_attributes_for :schedules, allow_destroy: true,
        reject_if: proc{ |x| x['start_time'].blank? }

    def self.per_page
        10
    end
  end
end
