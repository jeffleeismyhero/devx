module Devx
  class Role < ActiveRecord::Base
    has_many :authorizations
    has_many :users, through: :authorizations
    
    validates :name, presence: true, uniqueness: true
  end
end
