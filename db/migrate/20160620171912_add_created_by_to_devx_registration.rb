class AddCreatedByToDevxRegistration < ActiveRecord::Migration
  def change
    add_column :devx_registrations, :user_id, :integer
  end
end
