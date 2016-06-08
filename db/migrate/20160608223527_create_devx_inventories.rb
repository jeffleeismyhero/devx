class CreateDevxInventories < ActiveRecord::Migration
  def change
    create_table :devx_inventories do |t|

      t.timestamps null: false
    end
  end
end
