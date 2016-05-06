class CreateDevxTransactions < ActiveRecord::Migration
  def change
    create_table :devx_transactions do |t|
      t.belongs_to :order
      t.string :payment_method
      t.float :amount
      t.text :comments

      t.timestamps null: false
    end
  end
end
