class AddFieldsToDevxAlumni < ActiveRecord::Migration
  def change
		add_column :devx_alumnis, :undergraduate, :string
		add_column :devx_alumnis, :degree_ug, :string
		add_column :devx_alumnis, :graduate, :string
		add_column :devx_alumnis, :degree_grad, :string
		add_column :devx_alumnis, :gender, :string
		add_column :devx_alumnis, :twitter, :string
		add_column :devx_alumnis, :facebook, :string
		add_column :devx_alumnis, :employer, :string
		add_column :devx_alumnis, :industry, :string
		add_column :devx_alumnis, :position, :string
		add_column :devx_alumnis, :employer_address, :string
		add_column :devx_alumnis, :employer_city, :string
		add_column :devx_alumnis, :employer_state, :string
		add_column :devx_alumnis, :employer_zip, :integer
  end
end
