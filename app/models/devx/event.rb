module Devx
  class Event < ActiveRecord::Base
    acts_as_taggable

    has_many :event_subscriptions
    has_many :schedules, dependent: :destroy
    belongs_to :calendar
    belongs_to :venue

    scope :upcoming, -> { where("start_time > ?", Time.zone.now).order(start_time: :asc) }
    scope :for, -> (start_time, end_time) { where('start_time > ? AND start_time < ?', start_time.beginning_of_month, end_time.end_of_month) }
    scope :uniq_dates, -> { uniq.pluck(:start_time) }

    validates :name, presence: true
    validate :check_for_duplicates

    accepts_nested_attributes_for :schedules, allow_destroy: true,
        reject_if: proc{ |x| x['start_time'].blank? }

    def self.per_page
        10
    end

    def check_for_duplicates

        # Devx::Event.all.each do |e|
        #     e = Devx::Event.where(name: e.name)
        #     found = 0
        #     e.try(:each_with_index) do |duplicate, index|
        #         if e.schedules.first.start_time == duplicate.schedules.first.start_time
        #             found += 1
        #         end
        #     end
        # end
    end
  end
end
