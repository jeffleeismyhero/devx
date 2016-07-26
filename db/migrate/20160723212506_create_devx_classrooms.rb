class CreateDevxClassrooms < ActiveRecord::Migration
  def change
    create_table :devx_classrooms do |t|

      t.timestamps null: false
    end
  end
end
