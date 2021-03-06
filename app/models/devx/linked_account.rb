module Devx
  class LinkedAccount < ActiveRecord::Base
    belongs_to :user
    belongs_to :person

    validates :user, presence: true
    validates :person_id, presence: true, uniqueness: { scope: [ :user_id ] }
  end
end
