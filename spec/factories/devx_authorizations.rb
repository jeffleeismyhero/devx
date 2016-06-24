FactoryGirl.define do

  factory :devx_authorization, class: 'Devx::Authorization' do
    user { create(:devx_user) }
    role { create(:devx_role) }
  end
end
