class CreateDevxLinkedAccounts < ActiveRecord::Migration
  def change
    create_table :devx_linked_accounts do |t|
      t.belongs_to :user
      t.belongs_to :person
      
      t.timestamps null: false
    end
  end
end
