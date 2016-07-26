class CreateDevxClassPhotos < ActiveRecord::Migration
  def change
    create_table :devx_class_photos do |t|
      t.belongs_to :class_gallery
      t.string :name
      t.string :caption
      t.string :filename
      t.timestamps null: false
    end
  end
end
