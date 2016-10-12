module Devx
  class ProductAttribute < ActiveRecord::Base
  	has_many :product_sku_attributes, dependent: :destroy
  	belongs_to :product

  	accepts_nested_attributes_for :product_sku_attributes, allow_destroy: true

    validates :product_attribute, presence: true
    validates :product, presence: true
  end
end
