module Devx
  class Registration < ActiveRecord::Base
    has_many :child_registrations
    has_many :children, through: :child_registrations
    has_many :attendances
    has_one :form
    has_many :registration_submissions

    accepts_nested_attributes_for :attendances
    accepts_nested_attributes_for :form

    attr_accessor :submission_content

    def attendance(child)
      self.attendances.where(child_id: child.id)
    end

    def enrolled?(child)
      if self.child_registrations.where('child_id = ?', child[:id]).count > 0
        return true
      else
        return false
      end
    end

    def enroll(child)
      unless enrolled?(child)
        self.child_registrations.create(child: Devx::Child.find(child[:id]))
      end
    end

    def checked_in?(child)
      self.attendances.where(child_id: child, check_out: nil).present?
    end

    def record_attendance(child)
      if self.checked_in?(child)
        record = self.attendances.where(child_id: child, check_out: nil).first
        record.update_columns(check_out: Time.zone.now)
      else
        self.attendances.create(child_id: child, check_in: Time.zone.now)
      end
    end
  end
end
