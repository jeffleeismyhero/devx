class AddTwitterAndFacebookToDevxBranding < ActiveRecord::Migration
  def change
    add_column :devx_brandings, :facebook, :string
    add_column :devx_brandings, :twitter, :string
  end
end
