class AddCustomTabNamesToDevxClassrooms < ActiveRecord::Migration
  def change
    add_column :devx_classrooms, :highlight_tab_name, :string, default: 'Highlights'
    add_column :devx_classrooms, :schedule_tab_name, :string, default: 'Schedule'
    add_column :devx_classrooms, :policies_and_procedures_tab_name, :string, default: 'Policies and Procedures'
  end
end
