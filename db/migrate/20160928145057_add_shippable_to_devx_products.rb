class AddShippableToDevxProducts < ActiveRecord::Migration
  def change
    add_column :devx_products, :shippable, :boolean
  end
end
