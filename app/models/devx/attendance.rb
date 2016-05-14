module Devx
  class Attendance < ActiveRecord::Base
    belongs_to :registration
    belongs_to :child
  end
end
