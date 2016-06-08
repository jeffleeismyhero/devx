class CreateDevxTeams < ActiveRecord::Migration
  def change
    create_table :devx_teams do |t|
    	t.belongs_to :sport
    	t.belongs_to :user

      t.timestamps null: false
    end
  end
end





