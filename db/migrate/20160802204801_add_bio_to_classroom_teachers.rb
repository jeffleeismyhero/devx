class AddBioToClassroomTeachers < ActiveRecord::Migration
  def change
  	add_column :devx_classroom_teachers, :bio, :text
  end
end
