class CreateDevxMedia < ActiveRecord::Migration
  def change
    create_table :devx_media do |t|
      t.string :name
      t.string :file

      t.timestamps null: false
    end
  end
end
