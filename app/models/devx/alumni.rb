module Devx
  class Alumni < ActiveRecord::Base
      
    mount_uploader :photo, ImageUploader  

    validates :prefix, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :gender, presence: true
    validates :graduation_year, presence: true
      
    def full_name
      "#{self.first_name} #{self.last_name}".squish
    end
  end
end
