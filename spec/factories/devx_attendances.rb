FactoryGirl.define do
  #sequence :article_subscription do |n|
  #  "subscription-#{n}"
  #end

  factory :devx_attendance, class: 'Devx::Attendance' do
    registration { create(:devx_registration) }
    child { create(:devx_child) }
  end
end
