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
    before_destroy :destroy_stripe_product

    def values
      {
        name: name,
        description: description,
        active: active,
        id: slug
      }
    end

    private

    def create_stripe_product
    	Stripe::Product.create(values.delete_if { |k, v| v.blank? unless k == :active })
      product_skus.collect(&:create_stripe_sku)
    end

    def update_stripe_product
      product = Stripe::Product.retrieve(slug)
      values = self.values.delete_if { |k, v| [:id].include?(k) }
      values = values.delete_if { |k, v| v.blank? }
      values.each_pair { |key, value| product.send("#{key}=", value) }
      product.active = self.values[:active] || false
  		product.save
    end

    def destroy_stripe_product
      Stripe::Product.retrieve(slug).try(:delete)
    end
  end
end
