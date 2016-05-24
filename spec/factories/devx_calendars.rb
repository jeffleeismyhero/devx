FactoryGirl.define do
  sequence :calendar_title do |n|
    "calendar-#{n}"
  end

  factory :devx_calendar, class: 'Devx::Calendar' do
    name { generate(:calendar_title) }
    active true
  end
end
