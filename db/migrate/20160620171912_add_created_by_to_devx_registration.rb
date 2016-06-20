class AddCreatedByToDevxRegistration < ActiveRecord::Migration
  def change
    add_column :devx_registrations, :belongs_to, :user
  end
end
