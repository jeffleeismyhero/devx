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

    attr_accessor :stripe_token

    def total
      line_items.to_a.sum(&:line_total)
    end

    def payments
      transactions.sum(:amount) rescue 0
    end

    def balance
      total - payments
    end
  end
end
