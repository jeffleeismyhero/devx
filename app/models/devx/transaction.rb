module Devx
  class Transaction < ActiveRecord::Base
    has_many :transaction_responses
    belongs_to :order

    validates :order_id, presence: true
    validates :amount, presence: true,
      numericality: { greater_than_or_equal_to: 0}

    def amount_in_cents
      (amount * 100).to_i
    end

    def process
      customer = find_or_create_stripe_customer(order.user)
      response = Stripe::Charge.create(
        customer: customer.id,
        amount: amount_in_cents,
        currency: 'usd'
      )
      record_response(response)
      true if response.captured
    rescue Stripe::CardError => e
      record_response({failure_message: e.message, failure_code: e.code})
      false
    end

    def record_response(response)
      transaction_responses.create(
        message: response["failure_message"],
        failure_code: response["failure_code"],
        token: response["id"],
        status: response.status,
        state: response.captured ? 'charged' : ''
      )
    end

    def find_or_create_stripe_customer(user)
      if user.token
        customer = Stripe::Customer.retrieve(user.token)
      end
      customer || create_stripe_customer(user)
    end
    private :find_or_create_stripe_customer

    def create_stripe_customer(user)
      if customer = Stripe::Customer.create(email: user.try(:email))
        user.update_column(:token, customer.id)
      end
      customer
    end
    private :create_stripe_customer
  end
end
