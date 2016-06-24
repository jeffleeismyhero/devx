FactoryGirl.define do
  #sequence :article_subscription do |n|
  #  "subscription-#{n}"
  #end

  factory :devx_child_registration, class: 'Devx::ChildRegistration' do
    registration { create(:devx_registration) }
    child { create(:devx_child) }
  end
end
