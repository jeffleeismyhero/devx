module Devx
  class Classroom < ActiveRecord::Base
  	extend FriendlyId
  	friendly_id :name, use: [ :slugged, :finders ]

  	has_many :classroom_teachers
  	has_many :people, through: :classroom_teachers
  	has_many :class_galleries
  	has_many :class_documents
  	has_many :class_highlights
    has_many :class_announcements
  	has_many :class_schedules
    has_many :classroom_custom_tabs
    belongs_to :layout

    accepts_nested_attributes_for :classroom_teachers
    accepts_nested_attributes_for :classroom_custom_tabs,
      reject_if: proc{ |x| x['tab_name'].blank? || x['content'].blank? }

    validates :highlight_tab_name, presence: true
    validates :schedule_tab_name, presence: true
    validates :policies_and_procedures_tab_name, presence: true

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end
