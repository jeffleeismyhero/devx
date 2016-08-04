class RemoveNamesFromDevxUsers < ActiveRecord::Migration
  def change
    remove_column :devx_users, :first_name
    remove_column :devx_users, :last_name
  end
end
