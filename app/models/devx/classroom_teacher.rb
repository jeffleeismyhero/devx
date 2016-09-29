module Devx
  class ClassroomTeacher < ActiveRecord::Base
  	belongs_to :person
  	belongs_to :classroom

  	validates :person_id, presence: true

  end
end
