class CreateDevxStudents < ActiveRecord::Migration
  def change
    create_table :devx_students do |t|
      t.belongs_to :person

      t.timestamps null: false
    end
  end
end
