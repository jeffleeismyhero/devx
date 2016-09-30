class CreateDevxProductAttributes < ActiveRecord::Migration
  def change
    create_table :devx_product_attributes do |t|
    	t.belongs_to :product, index: true
    	t.string :product_attribute

      t.timestamps null: false
    end
  end
end
