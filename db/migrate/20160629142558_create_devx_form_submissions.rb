class CreateDevxFormSubmissions < ActiveRecord::Migration
  def change
    create_table :devx_form_submissions do |t|

      t.timestamps null: false
    end
  end
end
