class CreateDevxClassSchedules < ActiveRecord::Migration
  def change
    create_table :devx_class_schedules do |t|
      t.belongs_to :classroom
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
