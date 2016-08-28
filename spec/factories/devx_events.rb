FactoryGirl.define do
  sequence :event_title do |n|
    "calendar-#{n}"
  end

  factory :devx_event, class: 'Devx::Event' do
    name { generate(:event_title) }
    description 'This is an event'

    transient do
      schedule_count 1
    end

    after(:build) do |event, evaluator|
      event.schedules = FactoryGirl.create_list(:devx_schedule, evaluator.schedule_count, event: event)
    end
  end
end
