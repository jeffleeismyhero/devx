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
  			:name => self.name,
  			:description => self.description,
  			:id => self.slug
		)
    end

    def update_stripe_product
    	product = Stripe::Product.retrieve(self.slug)
		product.description = self.description
		product.save
    end

    def destroy_stripe_product
    	product = Stripe::Product.retrieve(self.slug)

    	skus = Stripe::SKU.list.data

    	skus.try(:each) do |sku|
    		if sku.product == product.id
    			sku.delete
    		end
    	end

		product.delete

	rescue Stripe::InvalidRequestError
    end
  end
end
