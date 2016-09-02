class CreateDevxTransactionResponses < ActiveRecord::Migration
  def change
    create_table :devx_transaction_responses do |t|
      t.integer :transaction_id
      t.text :message
      t.text :code
      t.string :token
      t.string :state
      t.string :status

      t.timestamps null: false
    end
  end
end
