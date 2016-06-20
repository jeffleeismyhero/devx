module Devx
  class AccountTransaction < ActiveRecord::Base
    belongs_to :user

    validates :user, presence: true
    validates :transaction_type, presence: true
    validates :payment_method, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }
  end
end
