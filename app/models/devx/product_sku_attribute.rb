module Devx
  class ProductSkuAttribute < ActiveRecord::Base
  	belongs_to :product_attribute
  	belongs_to :product_sku
  end
end
