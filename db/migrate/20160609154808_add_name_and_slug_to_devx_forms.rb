class AddNameAndSlugToDevxForms < ActiveRecord::Migration
  def change
    add_column :devx_forms, :name, :string
    add_column :devx_forms, :slug, :string
  end
end
