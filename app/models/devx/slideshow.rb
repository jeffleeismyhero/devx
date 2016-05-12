module Devx
  class Slideshow < ActiveRecord::Base
    has_many :slides
    accepts_nested_attributes_for :slides, allow_destroy: true

    validates :name, presence: true
  end
end
