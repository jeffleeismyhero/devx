class AddLayoutIdToDevxClassrooms < ActiveRecord::Migration
  def change
    add_column :devx_classrooms, :layout_id, :integer
  end
end
