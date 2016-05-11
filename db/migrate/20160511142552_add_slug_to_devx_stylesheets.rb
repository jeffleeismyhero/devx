class AddSlugToDevxStylesheets < ActiveRecord::Migration
  def change
    add_column :devx_stylesheets, :slug, :string
    add_index :devx_stylesheets, :slug
  end
end
