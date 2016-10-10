class AddActiveToDevxSlides < ActiveRecord::Migration
  def change
    add_column :devx_slides, :active, :boolean
  end
end
