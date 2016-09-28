module Devx
  class Venue < ActiveRecord::Base
    has_many :events

    validates :address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true

    def full_address
      "#{self.address}, #{self.city}, #{self.state} #{self.zip}"
    end
  end
end
