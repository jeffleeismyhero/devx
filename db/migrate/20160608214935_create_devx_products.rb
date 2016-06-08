class CreateDevxProducts < ActiveRecord::Migration
  def change
    create_table :devx_products do |t|
      t.string :name
      t.text :description
      t.string :sku
      t.float :price
      t.float :weight
      t.boolean :taxable
      t.boolean :stockable

      t.timestamps null: false
    end
  end
end
