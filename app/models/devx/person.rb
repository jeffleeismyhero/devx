module Devx
  class Person < ActiveRecord::Base
    has_one :student
    has_one :user

    def full_name
      "#{self.first_name} #{self.last_name}".squish
    end
  end
end
