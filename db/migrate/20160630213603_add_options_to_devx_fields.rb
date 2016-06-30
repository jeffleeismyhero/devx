class AddOptionsToDevxFields < ActiveRecord::Migration
  def change
    add_column :devx_fields, :options, :string
  end
end
