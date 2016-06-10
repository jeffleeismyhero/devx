class AddPersonToDevxUsers < ActiveRecord::Migration
  def change
    add_reference :devx_users, :person, index: true, foreign_key: true
  end
end
