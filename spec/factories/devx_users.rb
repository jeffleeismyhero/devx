FactoryGirl.define do
  sequence :user_email do |n|
    "test-user#{n}@domain.com"
  end

  factory :devx_user, class: 'Devx::User' do
    email { generate(:user_email) }
    password 'password'
  end
end
