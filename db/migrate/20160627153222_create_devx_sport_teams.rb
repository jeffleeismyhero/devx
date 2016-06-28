class CreateDevxSportTeams < ActiveRecord::Migration
  def change
    create_table :devx_sport_teams do |t|
      t.belongs_to :sport
      t.belongs_to :person
      t.integer :jersey_number
      t.string :position
      t.string :height
      t.string :weight

      t.timestamps null: false
    end
  end
end
