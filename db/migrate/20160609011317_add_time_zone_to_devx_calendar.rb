class AddTimeZoneToDevxCalendar < ActiveRecord::Migration
  def change
    add_column :devx_calendars, :time_zone, :string
  end
end
