class AddPaymentDetailsToDevxOrders < ActiveRecord::Migration
  def change
    add_column :devx_orders, :stripe_id, :string
    add_column :devx_orders, :amount, :float
    add_column :devx_orders, :status, :string
  end
end
