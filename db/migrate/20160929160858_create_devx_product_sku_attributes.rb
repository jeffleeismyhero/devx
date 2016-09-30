class CreateDevxProductSkuAttributes < ActiveRecord::Migration
  def change
    create_table :devx_product_sku_attributes do |t|
    	t.belongs_to :product_sku, index: true
    	t.belongs_to :product_attribute, index: true
    	t.string :value

      t.timestamps null: false
    end
  end
end
