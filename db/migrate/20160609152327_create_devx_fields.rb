class CreateDevxFields < ActiveRecord::Migration
  def change
    create_table :devx_fields do |t|
      t.belongs_to :form
      t.string :name
      t.string :field_type
      t.integer :field_size
      t.boolean :required

      t.timestamps null: false
    end
  end
end
