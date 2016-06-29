class AddAdditionalFieldsToDevxRegistration < ActiveRecord::Migration
  def change
    add_column :devx_registrations, :cost, :float
    add_column :devx_registrations, :submission_recipients, :string
  end
end
