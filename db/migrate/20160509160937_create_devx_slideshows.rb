class CreateDevxSlideshows < ActiveRecord::Migration
  def change
    create_table :devx_slideshows do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
