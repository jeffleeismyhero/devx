class AddSiteNameToDevxBranding < ActiveRecord::Migration
  def change
    add_column :devx_brandings, :site_name, :string
  end
end
