class CreateDevxEventSubscriptions < ActiveRecord::Migration
  def change
    create_table :devx_event_subscriptions do |t|
      t.belongs_to :user
      t.belongs_to :event

      t.timestamps null: false
    end
  end
end
