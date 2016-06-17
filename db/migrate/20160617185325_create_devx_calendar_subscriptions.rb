class CreateDevxCalendarSubscriptions < ActiveRecord::Migration
  def change
    create_table :devx_calendar_subscriptions do |t|
      t.belongs_to :user
      t.belongs_to :calendar

      t.timestamps null: false
    end
  end
end
