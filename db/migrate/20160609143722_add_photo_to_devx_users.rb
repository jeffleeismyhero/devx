class AddPhotoToDevxUsers < ActiveRecord::Migration
  def change
    add_column :devx_users, :photo, :string
  end
end
