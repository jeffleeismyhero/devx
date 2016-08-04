module Devx
  class Classroom < ActiveRecord::Base
  	extend FriendlyId
  	friendly_id :name, use: [ :slugged, :finders ]

  	has_many :classroom_teachers
  	has_many :people, through: :classroom_teachers
  	has_many :class_galleries
  	has_many :class_documents
  	has_many :class_highlights
  	has_many :class_schedules
    belongs_to :layout

    accepts_nested_attributes_for :classroom_teachers, allow_destroy: true
  end
end
