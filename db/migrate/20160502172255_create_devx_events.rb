class CreateDevxEvents < ActiveRecord::Migration
  def change
    create_table :devx_events do |t|
      t.belongs_to :venue
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :contact_name
      t.string :contact_email

      t.timestamps null: false
    end
  end
end
