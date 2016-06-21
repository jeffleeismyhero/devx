module Devx
  class Event < ActiveRecord::Base
    extend TimeSplitter::Accessors
    split_accessor :start_time

    acts_as_taggable

    has_many :event_subscriptions
    belongs_to :calendar
    belongs_to :venue

    scope :upcoming, -> { where("start_time > ?", Time.zone.now).order(start_time: :asc) }
    scope :for, -> (start_time, end_time) { where('start_time > ? AND start_time < ?', start_time.beginning_of_month, end_time.end_of_month) }
    scope :uniq_dates, -> { uniq.pluck(:start_time) }

    validates :name, presence: true
    validates :start_time, presence: true
  end
end
