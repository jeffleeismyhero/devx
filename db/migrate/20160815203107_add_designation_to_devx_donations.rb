class AddDesignationToDevxDonations < ActiveRecord::Migration
  def change
    add_column :devx_donations, :designation, :string
  end
end
