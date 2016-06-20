module Devx
  class LineItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    validates :order_id, presence: true
    validates :product, presence: true, uniqueness: { scope: [ :order_id ] }
    validates :quanity, presence: true, numericality: { greater_than: 0 }
  end
end
