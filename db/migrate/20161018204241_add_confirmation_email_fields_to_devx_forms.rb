class AddConfirmationEmailFieldsToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :send_confirmation_email, :boolean, default: false
    add_column :devx_forms, :confirmation_email_from, :string
    add_column :devx_forms, :confirmation_email_subject, :string
    add_column :devx_forms, :confirmation_email_text, :text
  end
end
