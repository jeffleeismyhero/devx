module Devx
  class Product < ActiveRecord::Base
    acts_as_paranoid

    has_many :line_items
  end
end
