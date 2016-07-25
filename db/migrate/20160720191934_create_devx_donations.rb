class CreateDevxDonations < ActiveRecord::Migration
  def change
    create_table :devx_donations do |t|
      t.belongs_to :user
      t.float :amount
      t.string :cardholder_first_name
      t.string :cardholder_last_name
      t.string :billing_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :affiliation

      t.boolean :class_participation

      t.boolean :in_memorium
      t.string :dedicated_to
      t.string :email_to_notify

      t.boolean :company_match
      t.string :company_name
      t.string :company_email_to_notify

      t.timestamps null: false
    end
  end
end
