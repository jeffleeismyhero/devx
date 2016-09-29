module Devx
  class LineItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product_sku#, -> { with_deleted }

    validates :product_sku_id, presence: true, uniqueness: { scope: [ :order_id ] }
    validates :quantity, presence: true, numericality: { greater_than: 0 }

    def line_total
      product_sku.try(:price) * quantity rescue 0
    end
  end
end
