class CreateDevxRoles < ActiveRecord::Migration
  def change
    create_table :devx_roles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
