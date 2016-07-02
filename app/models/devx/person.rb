module Devx
  class Person < ActiveRecord::Base
  	scope :students, -> { tagged_with("Student").active }
  	# scope :parents, -> { tagged_with('Parent').active }
  	scope :faculty, -> { tagged_with('Faculty').active }
  	# scope :staff, -> { tagged_with('Staff').active }
  	# scope :prospects, -> { tagged_with('Prospect').active }
  	# scope :alumni, -> { tagged_with('Alumni').active }
  	scope :active, -> { where(active: true) }

    has_one :user

    acts_as_taggable_on :associations
    acts_as_taggable_on :departments


    mount_uploader :photo, ImageUploader

    def full_name
      "#{self.first_name} #{self.last_name}".squish
    end

    def record_with_uuid
      if self.uuid.present?
      	"(#{self.uuid}) #{self.try(:full_name)}"
      else
      	self.try(:full_name)
      end
    end
  end
end
