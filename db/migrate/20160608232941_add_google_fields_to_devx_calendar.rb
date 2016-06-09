class AddGoogleFieldsToDevxCalendar < ActiveRecord::Migration
  def change
    add_column :devx_calendars, :google_calendar_id, :string
    add_column :devx_calendars, :client_id, :string
    add_column :devx_calendars, :client_secret, :string
    add_column :devx_calendars, :calendar_type, :string
    add_column :devx_calendars, :authorization_url, :string
    add_column :devx_calendars, :authorization_code, :string
    add_column :devx_calendars, :refresh_token, :string
  end
end
