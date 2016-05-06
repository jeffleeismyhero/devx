module Devx
  class Order < ActiveRecord::Base
    has_many :transactions, dependent: :destroy
    belongs_to :user

    accepts_nested_attributes_for :transactions,
      reject_if: proc{ |x| x['amount'] = 0.0 }
  end
end
