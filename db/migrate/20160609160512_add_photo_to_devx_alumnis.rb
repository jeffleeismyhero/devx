class AddPhotoToDevxAlumnis < ActiveRecord::Migration
  def change
    add_column :devx_alumnis, :photo, :string
  end
end
