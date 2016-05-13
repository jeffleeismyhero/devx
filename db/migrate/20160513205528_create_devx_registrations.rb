class CreateDevxRegistrations < ActiveRecord::Migration
  def change
    create_table :devx_registrations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
