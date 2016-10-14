class AddSuccessMessageToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :success_message, :string
  end
end
