module Devx
  class Product < ActiveRecord::Base
    acts_as_paranoid

    has_many :line_items
    has_many :orders, through: :line_items
  end
end
