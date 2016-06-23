module Devx
  class Attendance < ActiveRecord::Base
    belongs_to :registration
    belongs_to :child

    validates :registration_id, presence: true
    validates :child_id, presence: true
  end
end
