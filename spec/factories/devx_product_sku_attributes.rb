FactoryGirl.define do
  factory :devx_product_sku_attribute, class: 'Devx::ProductSkuAttribute' do
    product_sku { create(:devx_product_sku) }
    product_attribute { create(:devx_product_attribute) }
    value 'Value'
  end
end
