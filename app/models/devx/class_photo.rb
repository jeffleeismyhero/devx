module Devx
  class ClassPhoto < ActiveRecord::Base
  	belongs_to :class_gallery

  	validates :class_gallery, presence: true
  	validates :filename, presence: true

    mount_uploader :filename, Devx::ImageUploader
  end
end
