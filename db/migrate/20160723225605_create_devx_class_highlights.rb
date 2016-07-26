class CreateDevxClassHighlights < ActiveRecord::Migration
  def change
    create_table :devx_class_highlights do |t|
      t.belongs_to :classroom
      t.string :title
      t.string :content
      t.string :image

      t.timestamps null: false
    end
  end
end
