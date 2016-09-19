module Devx
  class ApplicationSetting < ActiveRecord::Base
    serialize :settings, Hash

    after_save :reinit

    def reinit
      Devx::ApplicationSetting.initialize_settings
    end

    def self.initialize_settings
      Devx::StripeConfigurator.new
      Devx::SmsAlert.new
    end
  end
end
