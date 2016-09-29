module Devx
  class ClassGallery < ActiveRecord::Base
    scope :active, -> { where(active: true) }

  	belongs_to :classroom
  	has_many :class_photos

  	validates :classroom, presence: true
  	validates :name, presence: true
  end
end
