class CreateDevxSports < ActiveRecord::Migration
  def change
    create_table :devx_sports do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
