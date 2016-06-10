class CreateDevxPeople < ActiveRecord::Migration
  def change
    create_table :devx_people do |t|
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :suffix
      t.date :birthdate
      t.string :gender
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
