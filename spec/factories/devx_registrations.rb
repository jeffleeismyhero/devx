FactoryGirl.define do
  sequence :registration_name do |n|
    "registered-name#{n}"
  end

  factory :devx_registration, class: 'Devx::Registration' do
    name { generate(:registration_name) }
  end
end