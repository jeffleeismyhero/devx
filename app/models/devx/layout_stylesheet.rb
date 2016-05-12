module Devx
  class LayoutStylesheet < ActiveRecord::Base
    belongs_to :layout
    belongs_to :stylesheet

    validates :stylesheet, presence: true, uniqueness: { scope: [ :layout_id ] }
    validates :layout_id, presence: true
  end
end
