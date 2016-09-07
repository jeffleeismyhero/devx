class ChangeStartTimeAndEndTimeToTimeColumnsOnDevxClassroomSchedules < ActiveRecord::Migration
  def change
    change_column :devx_class_schedules, :start_time, :time
    change_column :devx_class_schedules, :end_time, :time
  end
end
