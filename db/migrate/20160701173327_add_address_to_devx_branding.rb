class AddAddressToDevxBranding < ActiveRecord::Migration
  def change
    add_column :devx_brandings, :address, :string
  end
end
