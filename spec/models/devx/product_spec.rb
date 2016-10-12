require 'rails_helper'

module Devx
  RSpec.describe Product, type: :model do
    let(:product){ FactoryGirl.create(:devx_product) }

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

    describe 'name' do
      it 'is invalid if blank' do
        product.name = nil
        expect(product).not_to be_valid
      end

      it 'is valid when name is present' do
        expect(product).to be_valid
      end
    end

    describe 'stripe' do
      it 'is backed by a Stripe::Product' do
        expect(product.slug).to be_present
        stripe_product = Stripe::Product.retrieve(product.slug)
        expect(stripe_product.name).not_to be_nil
      end

      it 'removes Stripe::Product when destroyed' do
        stripe_product = Stripe::Product.retrieve(product.slug)
        expect(stripe_product.name).not_to be_nil
        product.destroy
        expect { Stripe::Product.retrieve(product.slug) }.to raise_error Stripe::InvalidRequestError
      end

      # it 'creates Stripe::SKU records for nested Devx::Sku records' do
      #   product = FactoryGirl.build(:devx_product)
      #   product.product_skus.build(
      #     currency: 'USD', price: 10.0, stockable: true, active: true
      #   )
      #   expect { product.save }.to change(Devx::Product, :count).by(1)
      #                         .and change(Devx::ProductSku, :count).by(1)
      #
      #   stripe_product = Stripe::Product.retrieve(product.slug)
      #   expect(stripe_product.name).not_to be_nil
      #   expect(stripe_product.skus.count).to eq(1)
      # end
      #
      # it 'removes Stripe::SKU records when destroyed' do
      #   product = FactoryGirl.build(:devx_product)
      #   product.product_skus.build(
      #     currency: 'USD', price: 10.0, stockable: true, active: true
      #   )
      #   expect { product.save }.to change(Devx::Product, :count).by(1)
      #                         .and change(Devx::ProductSku, :count).by(1)
      #
      #   stripe_product = Stripe::Product.retrieve(product.slug)
      #   expect(stripe_product.name).not_to be_nil
      #   expect(stripe_product.skus.count).to eq(1)
      #   product_sku = product.product_skus.first
      #
      #   product.destroy
      #   expect { Stripe::SKU.retrieve(product_sku.stripe_id) }.to raise_error Stripe::InvalidRequestError
      #   expect { Stripe::Product.retrieve(product.slug) }.to raise_error Stripe::InvalidRequestError
      # end
    end
  end
end
