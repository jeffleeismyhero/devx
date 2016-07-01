class CreateDevxContactSubmissions < ActiveRecord::Migration
  def change
    create_table :devx_contact_submissions do |t|

      t.timestamps null: false
    end
  end
end
