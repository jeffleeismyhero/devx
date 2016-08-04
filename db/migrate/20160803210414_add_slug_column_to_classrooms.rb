class AddSlugColumnToClassrooms < ActiveRecord::Migration
  def change
  	add_column :devx_classrooms, :slug, :string 
  end
end
