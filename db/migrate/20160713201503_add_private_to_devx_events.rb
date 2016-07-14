class AddPrivateToDevxEvents < ActiveRecord::Migration
  def change
    add_column :devx_events, :private, :boolean
  end
end
