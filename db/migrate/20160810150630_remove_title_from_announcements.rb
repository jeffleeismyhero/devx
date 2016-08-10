class RemoveTitleFromAnnouncements < ActiveRecord::Migration
  def change
  	remove_column :devx_announcements, :title, :string
  end
end
