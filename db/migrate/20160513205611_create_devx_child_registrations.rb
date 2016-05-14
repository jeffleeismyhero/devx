class CreateDevxChildRegistrations < ActiveRecord::Migration
  def change
    create_table :devx_child_registrations do |t|
      t.belongs_to :registration
      t.belongs_to :child

      t.timestamps null: false
    end
  end
end
