class AddPhotoToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :photo, :string
  end
end
