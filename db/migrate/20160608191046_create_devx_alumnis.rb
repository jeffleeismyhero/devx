class CreateDevxAlumnis < ActiveRecord::Migration
  def change
    create_table :devx_alumnis do |t|
      t.integer :user_id
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :suffix
      t.string :nickname
      t.date :birthdate
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone
      t.string :marital_status
      t.string :linked_in
      t.integer :graduation_year

      t.timestamps null: false
    end
  end
end
