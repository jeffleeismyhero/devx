class AddProcessedAtToDevxAccountTransactions < ActiveRecord::Migration
  def change
    add_column :devx_account_transactions, :processed_at, :datetime
  end
end
