class AddEmbedCodeToDevxCalendars < ActiveRecord::Migration
  def change
    add_column :devx_calendars, :embed_code, :text
  end
end
