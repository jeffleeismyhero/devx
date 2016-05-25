class CreateDevxMembers < ActiveRecord::Migration
  def change
    create_table :devx_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :department
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :website
      t.string :photo
      t.text :biography

      t.timestamps null: false
    end
  end
end
