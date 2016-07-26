module Devx
  class ClassPhoto < ActiveRecord::Base
  	belongs_to :class_gallery

  	validates :class_gallery, presence: true
  	validates :filename, presence: true
  end
end
