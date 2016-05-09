class CreateDevxSlides < ActiveRecord::Migration
  def change
    create_table :devx_slides do |t|
      t.belongs_to :slideshow
      t.string :title
      t.string :content
      t.string :image
      t.integer :position

      t.timestamps null: false
    end
  end
end
