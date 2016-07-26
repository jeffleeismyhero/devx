class CreateDevxClassGalleries < ActiveRecord::Migration
  def change
    create_table :devx_class_galleries do |t|
      t.belongs_to :classroom
      t.string :name
      t.boolean :active
      t.timestamps null: false
    end
  end
end
