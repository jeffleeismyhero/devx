module Devx
  class Student < ActiveRecord::Base
    belongs_to :person
  end
end
