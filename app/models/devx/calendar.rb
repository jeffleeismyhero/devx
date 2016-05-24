module Devx
  class Calendar < ActiveRecord::Base
    has_many :events

    validates :name, presence: true, uniqueness: { case_sensitive: false }
  end
end
