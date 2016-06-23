class AdduuidToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :uuid, :string
  end
end
