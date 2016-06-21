module Devx
  class Order < ActiveRecord::Base
    has_many :line_items, dependent: :destroy
    has_many :transactions, dependent: :destroy
    belongs_to :user

    validates :user_id, presence: true


    accepts_nested_attributes_for :line_items, allow_destroy: true,
      reject_if: proc{ |x| x['quantity'] == 0 }
    accepts_nested_attributes_for :transactions, allow_destroy: true,
      reject_if: proc{ |x| x['amount'].blank? }

    def total
      total = 0

      self.line_items.try(:each) do |line_item|
        total += (line_item.product.price * line_item.quantity)
      end

      return total
    end

    def balance
      payments = 0

      self.transactions.try(:each) do |transaction|
        payments += transaction.amount
      end

      return (self.total - payments)
    end

  end
end
