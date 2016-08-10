class CreateDevxClassAnnouncements < ActiveRecord::Migration
  def change
    create_table :devx_class_announcements do |t|
      t.belongs_to :classroom
      t.string :content

      t.timestamps null: false
    end
  end
end
