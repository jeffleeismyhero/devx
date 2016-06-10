class CreateDevxInventories < ActiveRecord::Migration
  def change
    create_table :devx_inventories do |t|
      t.belongs_to :product
      t.integer :amount
      
      t.timestamps null: false
    end
  end
end
