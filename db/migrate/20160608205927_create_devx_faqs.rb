class CreateDevxFaqs < ActiveRecord::Migration
  def change
    create_table :devx_faqs do |t|
      t.string :question
      t.text :answer

      t.timestamps null: false
    end
  end
end
