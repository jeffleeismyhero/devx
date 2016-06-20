FactoryGirl.define do
  sequence :article_subscription do |n|
    "subscription-#{n}"
  end

  factory :devx_article_subscription, class: 'Devx::ArticleSubscription' do
    user FactoryGirl.build(:devx_user) 
    category 'sports'
  end
end

