class AddCardholderToDevxAccountTransactions < ActiveRecord::Migration
  def change
    add_column :devx_account_transactions, :cardholder, :string
  end
end
