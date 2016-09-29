module Devx
  class Member < ActiveRecord::Base
    mount_uploader :photo, ImageUploader

    def full_name
      "#{first_name} #{last_name}".squish
    end
  end
end
