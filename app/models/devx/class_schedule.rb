module Devx
  class ClassSchedule < ActiveRecord::Base
    extend TimeSplitter::Accessors
    split_accessor :start_time, date_format: "%m/%d/%Y", time_format: "%I:%M %P"
    split_accessor :end_time, date_format: "%m/%d/%Y", time_format: "%I:%M %P"

    scope :for_teacher, -> (teacher) { where(classroom_teachers: teacher) }

  	belongs_to :classroom

  	validates :name, presence: true
  	validates :start_time, presence: true
  end
end
