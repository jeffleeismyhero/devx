module Devx
  class LineItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product, -> { with_deleted }

    validates :product_id, presence: true, uniqueness: { scope: [ :order_id ] }
    validates :quantity, presence: true, numericality: { greater_than: 0 }

    def line_total
      product.try(:price) * quantity rescue 0
    end
  end
end
