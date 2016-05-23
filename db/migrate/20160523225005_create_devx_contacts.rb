class CreateDevxContacts < ActiveRecord::Migration
  def change
    create_table :devx_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :subject
      t.string :message

      t.timestamps null: false
    end
  end
end
