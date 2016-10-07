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

    after_create :create_stripe_order

    def total
      line_items.to_a.sum(&:line_total)
    end

    def payments
      transactions.sum(:amount) rescue 0
    end

    def balance
      total - payments
    end

    def refund_through_stripe
      order = Stripe::Order.retrieve(self.stripe_id)

      if order.present? && refund = Stripe::Refund.create(charge: order.charge)
          return true
      else
        return false
      end
    rescue Stripe::InvalidRequestError
    end


    private

    def create_stripe_order
      customer = Stripe::Customer.retrieve(self.user.stripe_id)

      items = []
      self.line_items.try(:each) do |line_item|
        items << { type: 'sku', parent: line_item.product_sku.try(:stripe_id), quantity: line_item.quantity, description: line_item.product_sku.try(:product).try(:name), amount: (line_item.line_total * 100).to_i }
      end

      puts items.inspect

      order = Stripe::Order.create(
      currency: 'usd',
      customer: customer.id,
      items: items
      )

      if order.pay(customer: customer)
        # self.transactions.
      end

      self.update_columns(stripe_id: order.id)
    end
  end
end
