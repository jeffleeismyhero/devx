class AddRecipientsToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :recipients, :string
  end
end
