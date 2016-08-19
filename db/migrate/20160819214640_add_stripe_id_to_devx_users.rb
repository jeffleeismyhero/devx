class AddStripeIdToDevxUsers < ActiveRecord::Migration
  def change
    add_column :devx_users, :stripe_id, :string
  end
end
