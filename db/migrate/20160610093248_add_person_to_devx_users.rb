class AddPersonToDevxUsers < ActiveRecord::Migration
  def change
    add_reference :devx_users, :person_id, :integer
    add_index :devx_users, :person_id
  end
end
