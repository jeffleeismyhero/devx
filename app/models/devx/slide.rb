module Devx
  class Slide < ActiveRecord::Base
    belongs_to :slideshow

    mount_uploader :image, Devx::ImageUploader
  end
end
