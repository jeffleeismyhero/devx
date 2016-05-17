class AddAdditionalFieldsToDevxPages < ActiveRecord::Migration
  def change
    add_column :devx_pages, :parent, :integer
    add_column :devx_pages, :image, :string
    add_column :devx_pages, :active, :boolean
    add_reference :devx_pages, :parent, index: true, foreign_key: true
  end
end
