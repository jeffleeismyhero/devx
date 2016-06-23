FactoryGirl.define do

  factory :devx_authorization, class: 'Devx::Authorization' do
    user { create(:devx_user) }
    role_id 1
  end
end
