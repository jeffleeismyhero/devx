module Devx
  class LayoutStylesheet < ActiveRecord::Base
    belongs_to :layout
    belongs_to :stylesheet

    validates :layout, presence: true, uniqueness: { scope: [ :stylesheet_id ] }
    validates :stylesheet_id, presence: true
  end
end
