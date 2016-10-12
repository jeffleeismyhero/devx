require 'rails_helper'

module Devx
  RSpec.describe ProductAttribute, type: :model do
    let(:product_attribute){ FactoryGirl.create(:devx_product_attribute) }

    before(:all) do
      Rails.configuration.stripe = {
        publishable_key: 'pk_test_xBspDeWOapLw0oAh6yci2xGh',
        secret_key: 'sk_test_DG3ZjPAckcGfkV3QJ5SDCCxb'
      }
      Stripe.api_key = 'sk_test_DG3ZjPAckcGfkV3QJ5SDCCxb'
      # Delete all associated data
      Stripe::Product.list.each do |stripe_product|
        Stripe::SKU.list.each do |stripe_sku|
          stripe_sku.delete
        end
        stripe_product.delete
      end
    end

    after(:all) do
      Rails.configuration.stripe = {
        publishable_key: 'pk_test_xBspDeWOapLw0oAh6yci2xGh',
        secret_key: 'sk_test_DG3ZjPAckcGfkV3QJ5SDCCxb'
      }
      Stripe.api_key = 'sk_test_DG3ZjPAckcGfkV3QJ5SDCCxb'
      # Delete all associated data
      Stripe::Product.list.each do |stripe_product|
        Stripe::SKU.list.each do |stripe_sku|
          stripe_sku.delete
        end
        stripe_product.delete
      end
    end

    describe 'product attribute' do
      it 'should be valid with provided attributes' do
        expect(product_attribute).to be_valid
      end

      it 'should be invalid if product attribute is blank' do
        product_attribute.product_attribute = ''
        expect(product_attribute).not_to be_valid
      end
    end

    describe 'product' do
      it 'should be invalid if product is nil' do
        product_attribute.product = nil
        expect(product_attribute).not_to be_valid
      end
    end

    describe 'stripe' do
      it 'should be linked to Stripe::Product' do
        stripe_product = Stripe::Product.retrieve(product_attribute.product.slug)
        expect(stripe_product).not_to be_nil
      end
    end
  end
end
