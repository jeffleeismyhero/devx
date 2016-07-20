class AddDeletedAtToDevxEvents < ActiveRecord::Migration
  def change
    add_column :devx_events, :deleted_at, :datetime
  end
end
