class AddColumnsToDevxClassrooms < ActiveRecord::Migration
  def change
  	add_column :devx_classrooms, :welcome_message, :text
  	add_column :devx_classrooms, :policies_and_procedures, :text
  end
end
