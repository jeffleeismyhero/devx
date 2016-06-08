module Devx
  class LineItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    validates :order, presence: true
    validates :product, presence: true
    validates :quanity, presence: true, numericality: { greater_than: 0 }
  end
end
