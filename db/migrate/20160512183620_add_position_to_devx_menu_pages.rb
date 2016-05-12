class AddPositionToDevxMenuPages < ActiveRecord::Migration
  def change
    add_column :devx_menu_pages, :position, :integer
  end
end
