FactoryGirl.define do
  sequence :product_attribute_name do |n|
    "attribute-#{n}"
  end
  
  factory :devx_product_attribute, class: 'Devx::ProductAttribute' do
    product { create(:devx_product) }
    product_attribute { generate(:product_attribute_name) }
  end
end
