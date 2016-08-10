class AddEmployeeBioToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :bio, :text
  end
end
