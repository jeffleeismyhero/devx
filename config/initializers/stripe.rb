Rails.configuration.stripe = {
  #:publishable_key => ENV['TEST_PUBLISHABLE_KEY'],
  #:secret_key      => ENV['TEST_SECRET_KEY']

  :publishable_key => Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_publishable_key'],
  :secret_key      => Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_secret_key']
}

#Stripe.api_key = Devx::ApplicationSetting.find_or_create_by(id: 1).settings['stripe_secret_key']

Stripe.api_key = Rails.configuration.stripe[:secret_key]
