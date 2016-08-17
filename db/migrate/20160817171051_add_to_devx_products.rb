class AddToDevxProducts < ActiveRecord::Migration
  def change
  	add_column :devx_products, :stripe_id, :string
  	add_column :devx_products, :active, :boolean
  end
end
