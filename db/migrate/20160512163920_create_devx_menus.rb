class CreateDevxMenus < ActiveRecord::Migration
  def change
    create_table :devx_menus do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
