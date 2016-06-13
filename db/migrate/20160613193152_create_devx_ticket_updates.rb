class CreateDevxTicketUpdates < ActiveRecord::Migration
  def change
    create_table :devx_ticket_updates do |t|
      t.belongs_to :ticket
      t.belongs_to :user
      t.text :comment
      t.string :file

      t.timestamps null: false
    end
  end
end
