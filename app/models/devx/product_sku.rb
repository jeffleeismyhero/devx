module Devx
  class ProductSku < ActiveRecord::Base
  	belongs_to :product
  end
end
