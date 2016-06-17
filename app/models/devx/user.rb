module Devx
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :authorizations
    has_many :roles, through: :authorizations
    has_many :children
    has_many :child_registrations
    has_many :registrations, through: :child_registrations
    has_many :attendances
    has_many :account_transactions
    has_many :calendar_subscriptions
    has_many :event_subscriptions
    belongs_to :person

    validates :email, presence: true
      
    mount_uploader :photo, ImageUploader

    accepts_nested_attributes_for :children,
      reject_if: proc{ |x| x['first_name'].blank? }

    def full_name
      if !self.first_name.blank?
      "#{self.first_name} #{self.last_name}".squish 
      else
        self.email
      end
    end

    def super_administrator?
      self.roles.exists?(name: 'Super Administrator') || self.roles.exists?(name: 'Developer')
    end

    def administrator?
      self.roles.exists?(name: 'Administrator') || super_administrator?
    end

    def student?
      self.roles.exists?(name: 'Student')
    end

    def parent?
      self.roles.exists?(name: 'Parent')
    end

    def faculty
      self.roles.exists?(name: 'Faculty')
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
