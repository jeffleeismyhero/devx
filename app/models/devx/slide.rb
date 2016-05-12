module Devx
  class Slide < ActiveRecord::Base
    belongs_to :slideshow

    validates :image, presence: true
    validates :position, presence: true

    mount_uploader :image, Devx::ImageUploader
  end
end
