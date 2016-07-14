class CreateDevxSchedules < ActiveRecord::Migration
  def change
    create_table :devx_schedules do |t|
      t.belongs_to :event
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :repeat
      t.boolean :all_day
      t.text :days, array: true, default: []
      
      t.timestamps null: false
    end
  end
end
