module Devx
  class UserRegistration < ActiveRecord::Base
    belongs_to :user
    belongs_to :registration
  end
end
