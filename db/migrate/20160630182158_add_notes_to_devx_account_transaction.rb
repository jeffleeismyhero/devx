class AddNotesToDevxAccountTransaction < ActiveRecord::Migration
  def change
    add_column :devx_account_transactions, :store_id, :string
    add_column :devx_account_transactions, :receipt_number, :string
    add_column :devx_account_transactions, :upc, :string
    add_column :devx_account_transactions, :product, :string
  end
end
