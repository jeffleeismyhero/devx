FactoryGirl.define do
  sequence :product_name do |n|
    "Product #{n}"
  end

  factory :devx_product, class: 'Devx::Product' do
    name { generate(:product_name) }
  end
end
