class AddBillingAndShippingAddressesToDevxOrders < ActiveRecord::Migration
  def change
    add_column :devx_orders, :billing_address_1, :string
    add_column :devx_orders, :billing_address_2, :string
    add_column :devx_orders, :billing_address_city, :string
    add_column :devx_orders, :billing_address_state, :string
    add_column :devx_orders, :billing_address_zip_code, :string
    add_column :devx_orders, :shipping_address_1, :string
    add_column :devx_orders, :shipping_address_2, :string
    add_column :devx_orders, :shipping_address_city, :string
    add_column :devx_orders, :shipping_address_state, :string
    add_column :devx_orders, :shipping_address_zip_code, :string
  end
end
