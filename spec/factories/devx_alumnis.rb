FactoryGirl.define do
  sequence :alumni_title do |n|
    "alumni-#{n}"
  end

  factory :devx_alumni, class: 'Devx::Alumni' do
  	prefix 'Dr.'
    first_name 'John'
    last_name 'Doe'
    gender 'male'
    graduation_year 2006
  end
end


