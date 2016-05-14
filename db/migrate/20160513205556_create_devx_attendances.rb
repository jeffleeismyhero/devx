class CreateDevxAttendances < ActiveRecord::Migration
  def change
    create_table :devx_attendances do |t|
      t.belongs_to :registration
      t.belongs_to :child
      t.datetime :check_in
      t.datetime :check_out

      t.timestamps null: false
    end
  end
end
