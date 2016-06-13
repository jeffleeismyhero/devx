class CreateDevxTickets < ActiveRecord::Migration
  def change
    create_table :devx_tickets do |t|
      t.belongs_to :user
      t.string :summary
      t.text :description
      t.string :location
      t.string :severity
      t.string :status
      t.string :file

      t.timestamps null: false
    end
  end
end
