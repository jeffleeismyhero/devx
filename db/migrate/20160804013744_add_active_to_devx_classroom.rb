class AddActiveToDevxClassroom < ActiveRecord::Migration
  def change
    add_column :devx_classrooms, :active, :boolean
  end
end
