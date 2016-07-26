module Devx
  class ClassSchedule < ActiveRecord::Base
  	belongs_to :classroom

  	validates :name, presence: true
  	validates :start_time, presence: true
  end
end
