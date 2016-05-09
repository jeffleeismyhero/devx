module Devx
  class Order < ActiveRecord::Base
    has_many :transactions, dependent: :destroy
    belongs_to :user

    accepts_nested_attributes_for :transactions, allow_destroy: true,
      reject_if: proc{ |x| x['amount'].blank? }
  end
end
