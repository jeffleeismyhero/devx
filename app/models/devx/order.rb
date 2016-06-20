module Devx
  class Order < ActiveRecord::Base
    has_many :line_items, dependent: :destroy
    has_many :transactions, dependent: :destroy
    belongs_to :user

    validates :user_id, presence: true

    accepts_nested_attributes_for :line_items, allow_destroy: true,
      reject_if: proc{ |x| x['product_id'].blank? || x['quantity'] == 0 }
    accepts_nested_attributes_for :transactions, allow_destroy: true,
      reject_if: proc{ |x| x['amount'].blank? }
  end
end
