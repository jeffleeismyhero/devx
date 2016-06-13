class CreateDevxAccountTransactions < ActiveRecord::Migration
  def change
    create_table :devx_account_transactions do |t|
      t.belongs_to :user
      t.string :transaction_type
      t.string :payment_method
      t.float :amount

      t.timestamps null: false
    end
  end
end
