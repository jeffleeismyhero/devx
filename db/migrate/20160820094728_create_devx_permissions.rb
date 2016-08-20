class CreateDevxPermissions < ActiveRecord::Migration
  def change
    create_table :devx_permissions do |t|
      t.belongs_to :role
      t.string :object_class
      t.string :action

      t.timestamps null: false
    end
  end
end
