class CreateDevxLayoutStylesheets < ActiveRecord::Migration
  def change
    create_table :devx_layout_stylesheets do |t|
      t.belongs_to :layout
      t.belongs_to :stylesheet

      t.timestamps null: false
    end
  end
end
