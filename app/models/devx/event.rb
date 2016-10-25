module Devx
  class Event < ActiveRecord::Base
    acts_as_taggable
    acts_as_paranoid

    has_many :event_subscriptions
    has_many :schedules, dependent: :destroy
    belongs_to :calendar
    belongs_to :venue

    scope :upcoming, -> { joins(:schedules).where("devx_schedules.start_time > ?", Time.zone.now).ordered }
    scope :ordered, -> { order('devx_schedules.start_time ASC, devx_schedules.end_time ASC') }
    scope :for, -> (start_time, end_time) { where('start_time > ? AND start_time < ?', start_time.beginning_of_month, end_time.end_of_month) }
    scope :uniq_dates, -> { uniq.pluck(:start_time) }

    validates :name, presence: true
    validates :schedules, presence: true
    validates :google_event_id, uniqueness: { scope: [:calendar_id] },
      allow_nil: true
    validate :check_for_duplicates

    accepts_nested_attributes_for :schedules, allow_destroy: true,
      reject_if: proc{ |x| x['start_time'].blank? && (x['start_time_date'].blank? || x['start_time_time'].blank?) }

    def self.per_page
      10
    end

    def check_for_duplicates
      duplicates = Devx::Event.where(name: self.name)
      duplicates.try(:each) do |duplicate|
        if duplicate != self
          duplicate.schedules.try(:each) do |dup_schedule|
            self.schedules.try(:each) do |schedule|
              if dup_schedule.start_time == schedule.start_time
                errors.add(:schedules, 'must be unique for each event')
                return false
              end
            end
          end
        end
      end
    end
  end
end
