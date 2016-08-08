class CreateDevxAnnouncements < ActiveRecord::Migration
  def change
    create_table :devx_announcements do |t|
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
