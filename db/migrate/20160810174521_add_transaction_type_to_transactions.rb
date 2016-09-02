class AddTransactionTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :devx_transactions, :transaction_type, :string
    add_column :devx_transactions, :status, :string
    add_column :devx_transactions, :state, :string
    add_column :devx_transactions, :payment_token, :string
  end
end
