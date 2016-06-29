class CreateDevxFormSubmissions < ActiveRecord::Migration
  def change
    create_table :devx_form_submissions do |t|
    	t.belongs_to :form
    	t.text :submission_content

      t.timestamps null: false
    end
  end
end
