class RestructureDevxForms < ActiveRecord::Migration
  def change
  	drop_table :devx_registration_submissions
  	create_table :devx_form_submissions do |t|
  		t.belongs_to :form
  		t.text :submission_content
  	end
  end
end
