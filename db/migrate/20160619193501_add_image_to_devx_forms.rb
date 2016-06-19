class AddImageToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :image, :string
  end
end
