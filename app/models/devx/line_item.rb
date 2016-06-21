module Devx
  class LineItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    validates :product, presence: true, uniqueness: { scope: [ :order_id ] }
    validates :quantity, presence: true, numericality: { greater_than: 0 }
  end
end
