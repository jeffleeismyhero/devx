class CreateDevxJavascripts < ActiveRecord::Migration
  def change
    create_table :devx_javascripts do |t|
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
