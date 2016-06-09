class CreateDevxUrgentNews < ActiveRecord::Migration
  def change
    create_table :devx_urgent_news do |t|
      t.string :title
      t.text :message
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
