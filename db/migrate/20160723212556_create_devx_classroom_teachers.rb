class CreateDevxClassroomTeachers < ActiveRecord::Migration
  def change
    create_table :devx_classroom_teachers do |t|

      t.belongs_to :person
      t.belongs_to :classroom 
      t.timestamps null: false
    end
  end
end
