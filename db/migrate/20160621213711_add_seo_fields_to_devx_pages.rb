class AddSeoFieldsToDevxPages < ActiveRecord::Migration
  def change
    add_column :devx_pages, :meta_title, :string
    add_column :devx_pages, :meta_keywords, :text
    add_column :devx_pages, :meta_robots, :string
    add_column :devx_pages, :meta_description, :string
  end
end
