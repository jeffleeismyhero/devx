module Devx
  class ClassSchedule < ActiveRecord::Base
    extend TimeSplitter::Accessors
    split_accessor :start_time
    split_accessor :end_time

  	belongs_to :classroom

  	validates :name, presence: true
  	validates :start_time, presence: true
  end
end
