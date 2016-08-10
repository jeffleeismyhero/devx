module Devx
  class Person < ActiveRecord::Base
    acts_as_paranoid

  	scope :students, -> { tagged_with("Student").active }
  	# scope :parents, -> { tagged_with('Parent').active }
  	scope :faculty, -> { tagged_with('Faculty').active }
  	# scope :staff, -> { tagged_with('Staff').active }
  	# scope :prospects, -> { tagged_with('Prospect').active }
  	# scope :alumni, -> { tagged_with('Alumni').active }
  	scope :active, -> { where(active: true) }

    has_one :user
    has_one :classroom_teacher
    has_one :classroom, through: :classroom_teacher

    has_many :linked_accounts
    has_many :users, through: :linked_accounts
    has_many :account_transactions

    acts_as_taggable_on :associations
    acts_as_taggable_on :departments


    mount_uploader :photo, ImageUploader

    accepts_nested_attributes_for :user


    def self.per_page
      10
    end

    def is_faculty?
      if self.tagged_with('Faculty', on: :associations).any?
        return true
      else
        return false
      end
    end

    def full_name
      "#{self.first_name} #{self.last_name}".squish
    end

    def record_with_uuid
      if self.uuid.present?
        "(#{self.uuid}) #{self.try(:full_name)}"
      else
        self.try(:full_name)
      end
    end

    def record_with_school_id
      if self.school_id.present?
      	"#{self.try(:full_name)} (#{self.school_id})"
      else
      	self.try(:full_name)
      end
    end

    def balance
      debit_bal = 0
      credit_bal = 0
      credits = self.account_transactions.where(transaction_type: 'Credit')
      debits = self.account_transactions.where(transaction_type: 'Debit')

      debits.try(:each) do |d|
        debit_bal += d.amount
      end

      credits.try(:each) do |c|
        credit_bal += c.amount
      end

      return credit_bal - debit_bal
    end
  end
end
