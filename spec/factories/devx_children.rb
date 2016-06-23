FactoryGirl.define do
  sequence :child_name do |n|
    "child-name#{n}"
  end

  factory :devx_child, class: 'Devx::Child' do
    first_name { generate(:child_name) }
    last_name "Mac"
  end
end