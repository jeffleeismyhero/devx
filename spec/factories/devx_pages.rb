FactoryGirl.define do
  sequence :page_name do |n|
    "page-#{n}"
  end

  factory :devx_page, class: 'Devx::Page' do
    name { generate(:page_name) }
    content 'This is a page'
  end
end
