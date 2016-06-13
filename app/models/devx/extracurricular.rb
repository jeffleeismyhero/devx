module Devx
  class Extracurricular < ActiveRecord::Base
  	scope :ordered, -> { order(name: :asc) }
  	validates :name, presence: true, uniqueness: true
  	mount_uploader :image, ImageUploader

    def self.per_page
      return 1
    end
  end
end

