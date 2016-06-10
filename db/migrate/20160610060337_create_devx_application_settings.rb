class CreateDevxApplicationSettings < ActiveRecord::Migration
  def change
    create_table :devx_application_settings do |t|
      t.text :settings

      t.timestamps null: false
    end
  end
end
