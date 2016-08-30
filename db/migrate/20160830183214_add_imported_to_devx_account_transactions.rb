class AddImportedToDevxAccountTransactions < ActiveRecord::Migration
  def change
    add_column :devx_account_transactions, :imported, :boolean
  end
end
