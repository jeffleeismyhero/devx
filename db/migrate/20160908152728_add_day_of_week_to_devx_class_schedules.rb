class AddDayOfWeekToDevxClassSchedules < ActiveRecord::Migration
  def change
    add_column :devx_class_schedules, :day_of_week, :text, array: true, default: []
  end
end
