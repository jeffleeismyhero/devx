module Devx
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable


    has_many :user_registrations
    has_many :registrations, through: :user_registrations
    has_many :attendances

    validates :email, presence: true

    def full_name
      if !self.first_name.nil?
      "#{self.first_name} #{self.last_name}".squish 
      else
        self.email
      end
    end
  end
end
