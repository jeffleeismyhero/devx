class AddMobileNumberToDevxPeople < ActiveRecord::Migration
  def change
    add_column :devx_people, :mobile_number, :string
  end
end
