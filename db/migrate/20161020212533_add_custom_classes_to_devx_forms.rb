class AddCustomClassesToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :custom_classes, :string
  end
end
