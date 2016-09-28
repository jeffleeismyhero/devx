module Devx
  class CalendarSubscription < ActiveRecord::Base
    belongs_to :calendar
    belongs_to :user

    validates :calendar, presence: true, uniqueness: { scope: [ :user_id ] }
    validates :user_id, presence: true
  end
end
