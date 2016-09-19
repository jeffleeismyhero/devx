module Devx
  class Slide < ActiveRecord::Base
    acts_as_list

    belongs_to :slideshow

    validates :image, presence: true

    mount_uploader :image, Devx::ImageUploader
  end
end
