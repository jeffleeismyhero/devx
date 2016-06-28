class AddModeratorFieldsToDevxSportsAndDevxExtracurriculars < ActiveRecord::Migration
  def change
  	add_column :devx_extracurriculars, :person_id, :integer
  	add_column :devx_sports, :person_id, :integer
  end
end
