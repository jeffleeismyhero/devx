class CreateDevxUserRegistrations < ActiveRecord::Migration
  def change
    create_table :devx_user_registrations do |t|
      t.belongs_to :registration
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
