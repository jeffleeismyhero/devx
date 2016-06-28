class DropDevxMembers < ActiveRecord::Migration
  def change
  	drop_table :devx_members
  end
end
