class AddDeletedAtToDevxSchedule < ActiveRecord::Migration
  def change
    add_column :devx_schedules, :deleted_at, :datetime
  end
end
