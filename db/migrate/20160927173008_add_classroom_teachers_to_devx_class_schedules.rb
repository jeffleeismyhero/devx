class AddClassroomTeachersToDevxClassSchedules < ActiveRecord::Migration
  def change
    add_column :devx_class_schedules, :classroom_teachers, :text, default: [], array: true
  end
end
