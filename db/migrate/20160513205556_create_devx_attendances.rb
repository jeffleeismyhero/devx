class CreateDevxAttendances < ActiveRecord::Migration
  def change
    create_table :devx_attendances do |t|
      t.belongs_to :registration
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
