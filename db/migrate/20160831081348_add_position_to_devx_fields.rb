class AddPositionToDevxFields < ActiveRecord::Migration
  def change
    add_column :devx_fields, :position, :integer
  end
end
