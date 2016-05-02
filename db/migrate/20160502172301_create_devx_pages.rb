class CreateDevxPages < ActiveRecord::Migration
  def change
    create_table :devx_pages do |t|
      t.string :name
      t.string :slug
      t.string :content

      t.timestamps null: false
    end
  end
end
