module Devx
  class ProductSku < ActiveRecord::Base
    after_update :update_stripe_sku
    before_destroy :delete_stripe_sku
    after_create :save_attributes
    after_create :create_stripe_sku

    has_many :line_items
    has_many :orders, through: :line_items
    has_many :product_sku_attributes, dependent: :destroy
  	belongs_to :product

    accepts_nested_attributes_for :product_sku_attributes, allow_destroy: true

    validates :product_id, presence: true

    def values
      if stockable
  			inventory = 'finite'
  			quantity = 0
  		end

      attributes = {}
      # self.product.try(:product_attributes).try(:each) do |attribute|
      #   puts self.id
      #   attributes[attribute.product_attribute.try(:to_s)] = Devx::ProductSkuAttribute.where(product_sku_id: self.id, product_attribute_id: attribute.id).collect{ |x| x.value }
      #   attributes[attribute.product_attribute].to_s
      # end
      # puts attributes.inspect

      self.product_sku_attributes.try(:each) do |attribute|
        attributes[attribute.product_attribute.product_attribute] = attribute.value
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

    def get_product_attribute

    end

    def get_attribute(value)
      self.product_sku_attributes.where(product_attribute_id: value).collect{ |x| x.value }
    end

    def save_attributes
      self.product_sku_attributes.try(:each) do |attribute|
        if attribute.new_record?
          attribute.save
        end
      end
    end

  	def create_stripe_sku
      puts self.id
      logger.debug "Creating Sku"
      logger.debug values.inspect

  		product = Stripe::Product.retrieve(self.product.slug)
  		logger.debug sku = product.skus.create(values.delete_if { |k, v| !v.present? unless k == :active })

      update_columns(stripe_id: sku.id)
  	end

    def update_stripe_sku
      logger.debug "Updating sku"
      logger.debug values.inspect

      sku = Stripe::SKU.retrieve(stripe_id)
      values = self.values.delete_if { |k, v| [:id].include?(k) }
      values = values.delete_if { |k, v| !v.present? }
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
