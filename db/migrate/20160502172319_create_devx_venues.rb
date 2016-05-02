class CreateDevxVenues < ActiveRecord::Migration
  def change
    create_table :devx_venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps null: false
    end
  end
end
