class AddSlugToDevxProducts < ActiveRecord::Migration
  def change
  	add_column :devx_products, :slug, :string
  end
end
