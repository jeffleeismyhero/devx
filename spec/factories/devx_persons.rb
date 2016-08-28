FactoryGirl.define do
  sequence :person_first_name do |n|
    "John #{n}"
  end

  sequence :person_last_name do |n|
    "Doe #{n}"
  end

  factory :devx_person, class: 'Devx::Person' do
    first_name { generate(:person_first_name) }
    last_name { generate(:person_last_name) }
  end
end
