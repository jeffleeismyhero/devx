module Devx
  class User < ActiveRecord::Base
    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/

    scope :hide_sa, -> { roles.exists?(name: 'Super Administrator') }
    scope :allow_sms, -> { where(receive_text_notifications: true) }

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :lockable, :timeoutable, :omniauthable, omniauth_providers: [ :google_oauth2 ]

    acts_as_paranoid

    has_many :authorizations
    has_many :roles, through: :authorizations
    has_many :child_registrations
    has_many :registrations, through: :child_registrations
    has_many :attendances
    has_many :calendar_subscriptions
    has_many :event_subscriptions
    has_many :article_subscriptions
    has_many :linked_accounts, dependent: :destroy
    has_many :children, through: :linked_accounts, class_name: 'Devx::Person', source: :person
    has_many :children_linked_accounts, through: :children, source: :linked_accounts
    has_many :orders

    # Student-based relationships
    has_many :links_to_parents, class_name: 'Devx::LinkedAccount', primary_key: 'person_id', foreign_key: 'person_id'
    has_many :parents, through: :links_to_parents, source: :user
    has_many :account_transactions, through: :person

    # Parent-based relationships
    has_many :links_to_students, class_name: 'Devx::LinkedAccount', primary_key: 'id', foreign_key: 'user_id'
    has_many :students, through: :links_to_students, source: :person
    has_many :student_account_transactions, through: :students, source: :account_transactions


    belongs_to :person

    validates :email, presence: true

    attr_accessor :generate_password, :first_name, :last_name

    after_create :welcome
    after_create :update_crm_record

    mount_uploader :photo, ImageUploader

    accepts_nested_attributes_for :person
      # reject_if: proc{ |x| x['first_name'].blank? }
    accepts_nested_attributes_for :linked_accounts, allow_destroy: true



    def self.per_page
      10
    end

    def self.get_user(email)
      find_by(email: email).try(:id) || nil
    end

    def full_name
      if !self.first_name.blank?
      "#{self.first_name} #{self.last_name}".squish
      else
        self.email
      end
    end

    def full_name=(value)
      if parts = value.rpartition(' ') rescue [value]
        self.first_name = parts.first
        self.last_name = parts.last
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

    def faculty?
      self.roles.exists?(name: 'Faculty')
    end

    def balance_manager?
      self.roles.exists?(name: 'Balance Manager')
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)
      # Get the identity and user if they exist
      identity = Identity.find_for_oauth(auth)

      # If a signed_in_resource is provided it always overrides the existing user
      # to prevent the identity being locked with accidentally created accounts.
      # Note that this may leave zombie accounts (with no associated identity) which
      # can be cleaned up at a later date.
      user = signed_in_resource ? signed_in_resource : identity.user

      # Create the user if needed
      if user.nil?
        # Get the existing user by email if the provider gives us a verified email.
        # If no verified email was provided we assign a temporary email and ask the
        # user to verify it on the next step via UsersController.finish_signup
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email || auth.extra.id_info.email_verified)
        email = auth.info.email if email_is_verified
        user = User.find_by(email: email) if email
        image = auth.extra.raw_info.picture

        # Create the user if it's a new registration
        if user.nil?
          user = User.new(
            full_name: auth.extra.raw_info.name || email,
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
          )
          user.save!
        end
      end

      # Associate the identity with the user if needed
      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end

    def email_verified?
      self.email && self.email !~ TEMP_EMAIL_REGEX
    end

    def generate_password=(value)
      if value == true || value == 'true'
        self.password = Devise.friendly_token(12)
        self.password_confirmation = self.password
      end
    end

    def welcome
      Devx::NotificationMailer.delay.signup(self, self.password)
    end

    def balance
      if self.person.present?
        self.person.balance
      else
        0
      end
    end

    def update_crm_record
      self.person = Devx::Person.new unless self.person.present?
      self.person.first_name = self.first_name unless self.person.first_name.present?
      self.person.last_name = self.last_name unless self.person.last_name.present?
      self.person.email = self.email unless self.person.email.present?
      self.person.active = true unless self.person.active.present?

      if self.valid? && self.save
        logger.debug "Successfully created CRM record #{person.inspect}"
        return true
      else
        logger.debug "Failed to create CRM record #{person.inspect}"
        return false
      end
    end

    def create_stripe_record
      if Devx::ApplicationSetting.settings['stripe']
        # TODO
      end
    end

  end
end
