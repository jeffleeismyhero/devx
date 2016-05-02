class CreateDevxAuthorizations < ActiveRecord::Migration
  def change
    create_table :devx_authorizations do |t|
      t.belongs_to :user
      t.belongs_to :role

      t.timestamps null: false
    end
  end
end
