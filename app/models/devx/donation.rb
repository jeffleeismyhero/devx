module Devx
  class Donation < ActiveRecord::Base
    belongs_to :user
  end
end
