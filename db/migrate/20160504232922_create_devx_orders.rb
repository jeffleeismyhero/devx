class CreateDevxOrders < ActiveRecord::Migration
  def change
    create_table :devx_orders do |t|
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
