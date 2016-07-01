class AddLocationToDevxEvents < ActiveRecord::Migration
  def change
    add_column :devx_events, :location, :string
  end
end
