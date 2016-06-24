FactoryGirl.define do
  sequence :role_name do |n|
    "role-name#{n}"
  end

  factory :devx_role, class: 'Devx::Role' do
    name { generate(:role_name) }

    factory :super_administrator_role do
      name 'Super Administrator'
    end
  end
end