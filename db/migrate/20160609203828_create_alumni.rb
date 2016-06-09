class CreateAlumni < ActiveRecord::Migration
  def change
    create_table :alumnis do |t|
    	t.string :undergraduate
    	t.string :degree_ug
    	t.string :graduate
    	t.string :degree_grad
    	t.string :gender
    	t.string :twitter
    	t.string :facebook
    	t.string :employer
    	t.string :industry
    	t.string :position
    	t.string :employer_address
    	t.string :employer_city
    	t.string :employer_state
    	t.integer :employer_zip

    	t.timestamps null: false
    end
  end
end
