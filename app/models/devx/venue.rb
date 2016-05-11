module Devx
  class Venue < ActiveRecord::Base
    has_many :events
  end
end
