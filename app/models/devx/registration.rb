module Devx
  class Registration < ActiveRecord::Base
    has_many :user_registrations
    has_many :users, through: :user_registrations
    has_many :attendances
    has_one :form

    accepts_nested_attributes_for :attendances
    accepts_nested_attributes_for :form
  end
end
