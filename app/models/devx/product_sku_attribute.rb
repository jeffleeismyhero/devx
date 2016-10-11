module Devx
  class ProductSkuAttribute < ActiveRecord::Base
  	belongs_to :product_attribute
  	belongs_to :product_sku

  	attr_accessor :product_sku_id
  end
end
