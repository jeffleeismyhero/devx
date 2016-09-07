class CreateDevxClassroomCustomTabs < ActiveRecord::Migration
  def change
    create_table :devx_classroom_custom_tabs do |t|
      t.belongs_to :classroom
      t.string :tab_name
      t.text :content

      t.timestamps null: false
    end
  end
end
