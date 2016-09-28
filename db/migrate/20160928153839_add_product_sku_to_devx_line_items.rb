class AddProductSkuToDevxLineItems < ActiveRecord::Migration
  def change
    remove_column :devx_line_items, :product_id
    add_column :devx_line_items, :product_sku_id, :integer
  end
end
