module Devx
  class Extracurricular < ActiveRecord::Base
  	scope :ordered, -> { order(name: :asc) }
  	validates :name, presence: true, uniqueness: true
  	mount_uploader :image, ImageUploader
  end
end

