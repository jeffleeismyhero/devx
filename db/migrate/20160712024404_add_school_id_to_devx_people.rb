class AddSchoolIdToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :school_id, :string
  end
end
