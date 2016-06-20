module Devx
  class EventSubscription < ActiveRecord::Base
    belongs_to :event
    belongs_to :user

    validates :event, presence: true, uniqueness: { scope: [ :user_id ] }
    validates :user_id, presence: true
  end
end
