class UpdateAttributesForDevxClassSchedules < ActiveRecord::Migration
  def change
    remove_column :devx_class_schedules, :classroom_teachers
    add_column :devx_class_schedules, :classroom_teachers, :integer
  end
end
