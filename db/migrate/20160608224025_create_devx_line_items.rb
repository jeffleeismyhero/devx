class CreateDevxLineItems < ActiveRecord::Migration
  def change
    create_table :devx_line_items do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.integer :quanity

      t.timestamps null: false
    end
  end
end
