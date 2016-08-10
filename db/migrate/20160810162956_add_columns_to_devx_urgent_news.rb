class AddColumnsToDevxUrgentNews < ActiveRecord::Migration
  def change
  	add_column :devx_urgent_news, :content, :string
  	add_column :devx_urgent_news, :type, :string
  	add_column :devx_urgent_news, :send_to, :string
  	add_column :devx_urgent_news, :recipients, :string
  end
end
