FactoryGirl.define do
  factory :devx_schedule, class: 'Devx::Schedule' do
    association :event, factory: :devx_event
    start_time { Time.now }
    end_time { Time.now + 1.hour }
  end
end
