class CreateDevxExtracurricularTeams < ActiveRecord::Migration
  def change
    create_table :devx_extracurricular_teams do |t|
      t.belongs_to :extracurricular
      t.belongs_to :person

      t.timestamps null: false
    end
  end
end
