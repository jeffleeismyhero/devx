module Devx
  class ChildRegistration < ActiveRecord::Base
    belongs_to :child
    belongs_to :registration

    validates :registration_id, presence: true
    validates :child_id, presence: true
  end
end
