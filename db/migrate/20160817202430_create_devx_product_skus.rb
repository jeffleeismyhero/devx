class CreateDevxProductSkus < ActiveRecord::Migration
  def change
    create_table :devx_product_skus do |t|
      t.belongs_to :product

    	t.string :stripe_id
    	t.string :currency
    	t.float :price
    	t.boolean :stockable
    	t.boolean :active

     	t.timestamps null: false
    end
  end
end
