class AddSlugToDevxCalendar < ActiveRecord::Migration
  def change
    add_column :devx_calendars, :slug, :string
  end
end
