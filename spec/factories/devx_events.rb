FactoryGirl.define do
  sequence :event_title do |n|
    "calendar-#{n}"
  end

  factory :devx_event, class: 'Devx::Event' do
    name { generate(:event_title) }
    description 'This is an event'
    start_time Time.zone.now + 3.hours
    end_time Time.zone.now + 4.hours
  end
end
