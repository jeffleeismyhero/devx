class CreateDevxMenuPages < ActiveRecord::Migration
  def change
    create_table :devx_menu_pages do |t|
      t.belongs_to :menu
      t.belongs_to :page

      t.timestamps null: false
    end
  end
end
