class RemoveStartTimeAndEndTimeFromDevxEvents < ActiveRecord::Migration
  def change
    remove_column :devx_events, :start_time
    remove_column :devx_events, :end_time
  end
end
