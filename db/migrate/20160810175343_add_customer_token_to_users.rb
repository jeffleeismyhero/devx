class AddCustomerTokenToUsers < ActiveRecord::Migration
  def change
    add_column :devx_users, :customer_token, :string
  end
end
