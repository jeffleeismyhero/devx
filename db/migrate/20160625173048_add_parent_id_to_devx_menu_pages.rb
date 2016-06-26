class AddParentIdToDevxMenuPages < ActiveRecord::Migration
  def change
    add_column :devx_menu_pages, :parent_id, :integer
  end
end
