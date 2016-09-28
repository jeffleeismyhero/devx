module Devx
  class SmsAlert
    def initialize
      require 'twilio-ruby'

      Twilio.configure do |config|
        config.account_sid = Devx::ApplicationSetting.find_or_create_by(id: 1).settings['twilio_account_sid'] rescue nil
        config.auth_token = Devx::ApplicationSetting.find_or_create_by(id: 1).settings['twilio_auth_token'] rescue nil
      end

      @client = Twilio::REST::Client.new rescue nil
    end

    def client
      return @client
    end

    def send_message(to, body)
      phone_number = Devx::ApplicationSetting.find(1).settings['twilio_phone_number']

      @client.messages.create(from: phone_number, to: "+1#{to}", body: body)
    rescue Twilio::REST::RequestError
    end
  end
end
