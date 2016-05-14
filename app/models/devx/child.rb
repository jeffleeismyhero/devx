module Devx
  class Child < ActiveRecord::Base
    belongs_to :user

    validates :user, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true

    def full_name
      "#{self.first_name} #{self.last_name}".squish
    end
  end
end
