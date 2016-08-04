class AddDeletedAtToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :deleted_at, :datetime
  end
end
