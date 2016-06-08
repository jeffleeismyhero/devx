class AddCalendarIdToDevxEvents < ActiveRecord::Migration
  def change
    add_column :devx_events, :calendar_id, :integer, index: true
  end
end
