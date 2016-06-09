module Devx
  class Product < ActiveRecord::Base
  	t.belongs_to :product
  	t.integer :amount
  end
end
