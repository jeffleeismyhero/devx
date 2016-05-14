module Devx
  class ChildRegistration < ActiveRecord::Base
    belongs_to :child
    belongs_to :registration
  end
end
