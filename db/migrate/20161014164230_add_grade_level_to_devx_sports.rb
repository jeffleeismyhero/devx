class AddGradeLevelToDevxSports < ActiveRecord::Migration
  def change
  	add_column :devx_sport_teams, :grade, :string
  end
end
