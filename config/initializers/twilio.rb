require 'twilio-ruby'

account_sid = 'AC0d64f02be4f060bfb939ea266b70945f'
auth_token = 'e4cdb380609699b48aa7cc2f7bd342ca'

Twilio.configure do |config|
  config.account_sid = account_sid
  config.auth_token = auth_token
end

module Twilio
  def self.send(to, body)
    from = "+15046416384"
    @client = Twilio::REST::Client.new
    @client.messages.create(from: from, to: to, body: body)
  end
end