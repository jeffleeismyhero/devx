class AddSubmissionRecipientsToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :submission_recipients, :string
  end
end
