module Devx
  class ClassroomCustomTab < ActiveRecord::Base
    belongs_to :classroom

    validates :tab_name, presence: true
    validates :content, presence: true
  end
end
