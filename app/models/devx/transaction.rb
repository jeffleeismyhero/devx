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

    def charge?
      transaction_type ~= /Charge/i
    end

    def refund?
      !charge?
    end

    def process
      customer = find_or_create_stripe_customer(order.user)
      if charge?
        response = Stripe::Charge.create(
          customer: customer.id,
          amount: amount_in_cents,
          currency: 'usd'
        )
      else
        response = Stripe::Refund.create(
          customer: customer.id,
          amount: amount_in_cents,
          currency: 'usd'
        )
      end
      record_response(response)
      true if response.captured
    rescue Stripe::CardError => e
      record_response({failure_message: e.message, failure_code: e.code})
      false
    end

    # Record a Stripe response for each action.
    def record_response(response)
      transaction_responses.create(
        message: response["failure_message"],
        failure_code: response["failure_code"],
        token: response["id"],
        status: response.status,
        state: response.captured ? 'charged' : ''
      )
    end

    # Try to find the Customer at Stripe using the Customer Token value. If no
    # record is found, create the a Stripe Customer.
    def find_or_create_stripe_customer(user)
      if user.customer_token
        customer = Stripe::Customer.retrieve(user.customer_token)
      end
      customer || create_stripe_customer(user)
    end
    private :find_or_create_stripe_customer

    # Create a Customer at Stripe with metadata and update the user's Customer
    # Token value with the Token returned from Stripe.
    def create_stripe_customer(user)
      customer = Stripe::Customer.create(
        email: user.try(:email), metadata: {
          first_name: user.first_name, last_name: user.last_name
        }
      )
      user.update_column(:customer_token, customer.try(:id))
      customer
    end
    private :create_stripe_customer
  end
end
