class CreateDevxTransactions < ActiveRecord::Migration
  def change
    create_table :devx_transactions do |t|

      t.timestamps null: false
    end
  end
end
