module Devx
  class Transaction < ActiveRecord::Base
    belongs_to :order

    validates :order_id, presence: true
    validates :amount, presence: true,
      numericality: { greater_than_or_equal_to: 0}

    def amount_in_cents
      (amount * 100).to_i
    end
  end
end
