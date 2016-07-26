module Devx
  class ClassroomTeacher < ActiveRecord::Base
  	belongs_to :person
  	belongs_to :classroom

  	validates :person_id, presence: true
  	validates :classroom, presence: true, uniqueness: { scope: [:person_id] }
  end
end
