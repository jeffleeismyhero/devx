module Devx
  class Product < ActiveRecord::Base
  	extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    acts_as_paranoid

    has_many :line_items
    has_many :orders, through: :line_items
    has_many :product_skus, dependent: :destroy

    accepts_nested_attributes_for :product_skus, allow_destroy: true

    after_create :create_stripe_product
    after_update :update_stripe_product
    after_destroy :destroy_stripe_product

    private

    def create_stripe_product
    	Stripe::Product.create(
  			name: name,
  			description: description,
  			id: slug
  		)
    end

    def update_stripe_product
    	product = Stripe::Product.retrieve(slug)
  		product.description = description
  		product.save
    end

    def destroy_stripe_product
    	product = Stripe::Product.retrieve(slug)
    	skus = Stripe::SKU.list.data

    	skus.try(:each) do |sku|
    		sku.delete if sku.product == product.id
    	end

  		product.delete
  	rescue Stripe::InvalidRequestError
    end
  end
end
