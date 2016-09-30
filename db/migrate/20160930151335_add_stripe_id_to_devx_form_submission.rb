class AddStripeIdToDevxFormSubmission < ActiveRecord::Migration
  def change
    add_column :devx_form_submissions, :stripe_id, :string
    add_column :devx_form_submissions, :refunded, :boolean, default: false
  end
end
