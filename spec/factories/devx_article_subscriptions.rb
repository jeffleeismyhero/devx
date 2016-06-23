FactoryGirl.define do
  #sequence :article_subscription do |n|
  #  "subscription-#{n}"
  #end

  factory :devx_article_subscription, class: 'Devx::ArticleSubscription' do
    user { create(:devx_user) }
    category 'basketball'
  end
end

