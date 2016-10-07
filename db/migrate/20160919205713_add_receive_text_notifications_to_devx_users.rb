class AddReceiveTextNotificationsToDevxUsers < ActiveRecord::Migration
  def change
    add_column :devx_users, :receive_text_notifications, :boolean
  end
end
