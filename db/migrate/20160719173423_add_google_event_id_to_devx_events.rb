class AddGoogleEventIdToDevxEvents < ActiveRecord::Migration
  def change
    add_column :devx_events, :google_event_id, :string
  end
end
