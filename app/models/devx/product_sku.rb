module Devx
  class ProductSku < ActiveRecord::Base
    after_update :update_stripe_sku
    before_destroy :delete_stripe_sku

    has_many :line_items
    has_many :orders, through: :line_items
    has_many :product_sku_attributes, dependent: :destroy
  	belongs_to :product

    accepts_nested_attributes_for :product_sku_attributes, allow_destroy: true

    def values
      if stockable
  			inventory = 'finite'
  			quantity = 0
  		end

      attributes = {}
      self.product_sku_attributes.try(:each) do |attribute|
        attributes[attribute.product_attribute.try(:product_attribute).to_sym] = attribute.value
      end

      {
        price: (self.price * 100).to_i,
		   	currency: currency,
        active: active,
		   	inventory: {
		     	'type': inventory || 'infinite',
     			'quantity': quantity
		   	},
        attributes: attributes
      }
    end

    def price_in_cents
      (self.price * 100).to_i
    end

  	def create_stripe_sku
      logger.debug "Creating Sku"
      logger.debug values.inspect
  		product = Stripe::Product.retrieve(self.product.slug)
  		logger.debug sku = product.skus.create(values.delete_if { |k, v| !v.present? unless k == :active })
      update_columns(stripe_id: sku.id)
  	end

    def update_stripe_sku
      logger.debug "Updating sku"
      sku = Stripe::SKU.retrieve(stripe_id)
      values = self.values.delete_if { |k, v| [:id].include?(k) }
      values = values.delete_if { |k, v| v.blank? }
      values.each_pair { |key, value| sku.send("#{key}=", value) }
      sku.active = self.values[:active] || false
      logger.debug sku
  		sku.save
    end

  	def delete_stripe_sku
  		Stripe::SKU.retrieve(self.stripe_id).try(:delete)
    rescue Stripe::InvalidRequestError
  	end
  end
end
