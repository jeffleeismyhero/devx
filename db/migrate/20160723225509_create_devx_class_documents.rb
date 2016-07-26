class CreateDevxClassDocuments < ActiveRecord::Migration
  def change
    create_table :devx_class_documents do |t|
      t.belongs_to :classroom
      t.string :name
      t.string :filename

      t.timestamps null: false
    end
  end
end
