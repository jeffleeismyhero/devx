class AddLayoutToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :layout_id, :integer
  end
end
