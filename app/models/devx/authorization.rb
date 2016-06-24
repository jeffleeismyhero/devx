module Devx
  class Authorization < ActiveRecord::Base
    belongs_to :user
    belongs_to :role

    validates :user, presence: true, uniqueness: { scope: [ :role_id ] }
    validates :role_id, presence: true, numericality: { less_than: 10 }
  end
end
