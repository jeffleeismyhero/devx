class AddAdditionalBrandingFieldsToDevxBrandings < ActiveRecord::Migration
  def change
    add_column :devx_brandings, :alternate_logo, :string
    add_column :devx_brandings, :favicon, :string
    add_column :devx_brandings, :primary_color, :string
    add_column :devx_brandings, :secondary_color, :string
    add_column :devx_brandings, :accent_color_1, :string
    add_column :devx_brandings, :accent_color_2, :string
    add_column :devx_brandings, :accent_color_3, :string
  end
end
