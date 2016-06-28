class AddPositionAndActiveToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :position, :string
    add_column :devx_people, :active, :boolean
  end
end
