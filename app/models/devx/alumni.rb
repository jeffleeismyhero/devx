module Devx
  class Alumni < ActiveRecord::Base

    def full_name
      "#{self.first_name} #{self.last_name}".squish
    end
  end
end
