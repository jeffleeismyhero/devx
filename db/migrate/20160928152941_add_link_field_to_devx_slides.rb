class AddLinkFieldToDevxSlides < ActiveRecord::Migration
  def change
  	add_column :devx_slides, :link, :string
  end
end
