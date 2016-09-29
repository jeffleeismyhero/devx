module Devx
  class EventSubscription < ActiveRecord::Base
    scope :upcoming, -> { joins(:event).joins(:schedules).where('start_time > ?', Time.zone.now) }

    belongs_to :event
    belongs_to :user

    validates :event, presence: true, uniqueness: { scope: [ :user_id ] }
    validates :user_id, presence: true
  end
end
