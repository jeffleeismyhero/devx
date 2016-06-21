class AddImageToDevxProducts < ActiveRecord::Migration
  def change
    add_column :devx_products, :image, :string
  end
end
