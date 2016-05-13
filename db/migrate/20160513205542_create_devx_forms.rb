class CreateDevxForms < ActiveRecord::Migration
  def change
    create_table :devx_forms do |t|
      t.belongs_to :registration
      t.text :fields

      t.timestamps null: false
    end
  end
end
