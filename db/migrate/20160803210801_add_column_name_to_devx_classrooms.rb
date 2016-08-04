class AddColumnNameToDevxClassrooms < ActiveRecord::Migration
  def change
  	add_column :devx_classrooms, :name, :string
  end
end
