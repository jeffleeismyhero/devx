module Devx
  class Donation < ActiveRecord::Base
    belongs_to :user

    validates :user, presence: true
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :cardholder_first_name, presence: true
    validates :cardholder_last_name, presence: true
    validates :billing_address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip_code, presence: true
    validates :affiliation, presence: true
    validates :phone_number, presence: true

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end
