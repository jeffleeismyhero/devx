module Devx
  class ClassHighlight < ActiveRecord::Base
  	belongs_to :classroom

  	acts_as_taggable

  	validates :title, presence: true
  	validates :content, presence: true

    mount_uploader :image, Devx::ImageUploader
  end
end
