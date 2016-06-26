class CreateDevxIdentities < ActiveRecord::Migration
  def change
    create_table :devx_identities do |t|
      t.belongs_to :user
      t.string :provider
      t.string :uid
      
      t.timestamps null: false
    end
  end
end
