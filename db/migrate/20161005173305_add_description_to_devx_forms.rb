class AddDescriptionToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :description, :text
  end
end
