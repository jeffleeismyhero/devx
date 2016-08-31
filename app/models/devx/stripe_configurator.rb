module Devx
  class StripeConfigurator
    def initialize
      Rails.configuration.stripe = {
        publishable_key: Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_publishable_key'],
        secret_key: Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_secret_key']
      }

      Stripe.api_key = Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_secret_key']
    end
  end
end
