class CreateDevxSections < ActiveRecord::Migration
  def change
    create_table :devx_sections do |t|
      t.belongs_to :page
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
