module Devx
  class Permission < ActiveRecord::Base
    belongs_to :role

    validates :role_id, presence: true
    validates :object_class, presence: true
    validates :action, presence: true, uniqueness: { scope: [ :role_id ] }
  end
end
