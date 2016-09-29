module Devx
  class StripeConfigurator
    def initialize
      publishable_key = Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_publishable_key'] rescue nil
      stripe_secret_key = Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_secret_key'] rescue nil

      if publishable_key.present? && stripe_secret_key.present?
        Rails.configuration.stripe = {
          publishable_key: publishable_key,
          secret_key: stripe_secret_key
        }

        Stripe.api_key = stripe_secret_key
      end
    end
  end
end
