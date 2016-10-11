FactoryGirl.define do
  factory :devx_product_sku, class: 'Devx::ProductSku' do
  	product { create(:devx_product) }
  	currency 'usd'
  	price 9.99
  	stockable true
  	active true
  end
end
