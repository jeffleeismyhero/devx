module Devx
  class TransactionResponse < ActiveRecord::Base
    belongs_to :devx_transaction, class_name: 'Devx::Transaction'
  end
end
