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
  end
end
