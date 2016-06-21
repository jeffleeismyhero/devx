class RenameDevxLineItemsQuantityColumn < ActiveRecord::Migration
  def change
    rename_column :devx_line_items, :quanity, :quantity
  end
end
