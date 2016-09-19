module Devx
  class UrgentNews < ActiveRecord::Base
  	scope :latest, -> { order('start_time DESC').limit(1) }

  	validates :title, presence: true
  	validates :message, presence: true

    after_create :send_sms_alerts


    private

    def send_sms_alerts
      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['sms_alerts'].present?
        users = Devx::User.allow_sms

        sms_client = Devx::SmsAlert.new
        users.try(:each) do |user|
          sms_client.send_message(user.person.try(:mobile_number), "#{self.title} - #{self.message}")
        end
      end
    end
  end
end
