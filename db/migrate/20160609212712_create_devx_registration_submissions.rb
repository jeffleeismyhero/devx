class CreateDevxRegistrationSubmissions < ActiveRecord::Migration
  def change
    create_table :devx_registration_submissions do |t|
      t.belongs_to :registration
      t.text :submission_content

      t.timestamps null: false
    end
  end
end
