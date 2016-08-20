module Devx
  class Role < ActiveRecord::Base
    has_many :authorizations
    has_many :users, through: :authorizations
    has_many :permissions

    validates :name, presence: true, uniqueness: true

    accepts_nested_attributes_for :permissions, allow_destroy: true,
    reject_if: proc{ |x| x['object_class'].blank? }
  end
end
