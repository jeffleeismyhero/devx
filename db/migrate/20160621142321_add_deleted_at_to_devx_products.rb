class AddDeletedAtToDevxProducts < ActiveRecord::Migration
  def change
    add_column :devx_products, :deleted_at, :datetime
  end
end
