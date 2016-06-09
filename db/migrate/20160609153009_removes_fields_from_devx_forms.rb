class RemovesFieldsFromDevxForms < ActiveRecord::Migration
  def change
    remove_column :devx_forms, :fields
  end
end
