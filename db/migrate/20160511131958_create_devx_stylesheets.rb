class CreateDevxStylesheets < ActiveRecord::Migration
  def change
    create_table :devx_stylesheets do |t|
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
