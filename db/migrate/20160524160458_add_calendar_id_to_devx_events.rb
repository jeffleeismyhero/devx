class AddCalendarIdToDevxEvents < ActiveRecord::Migration
  def change
    add_reference :devx_events, :calendar, index: true, foreign_key: true
  end
end
