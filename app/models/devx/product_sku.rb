module Devx
  class ProductSku < ActiveRecord::Base
    after_update :update_stripe_sku
    before_destroy :delete_stripe_sku

  	belongs_to :product

    def values
      if stockable
  			inventory = 'finite'
  			quantity = 0
  		end

      {
        price: (price * 100).to_i,
		   	currency: currency,
        active: active,
		   	inventory: {
		     	'type': inventory || 'infinte',
     			'quantity': quantity
		   	}
      }
    end

    def price_in_cents
      (self.price * 100).to_i
    end

  	def create_stripe_sku
  		product = Stripe::Product.retrieve(self.product.slug)
  		sku = product.skus.create(values.delete_if { |k, v| v.blank? unless k == :active })
      update_attributes(stripe_id: sku.id)
  	end

    def update_stripe_sku
      sku = Stripe::SKU.retrieve(stripe_id)
      values = self.values.delete_if { |k, v| [:id].include?(k) }
      values = values.delete_if { |k, v| v.blank? }
      values.each_pair { |key, value| sku.send("#{key}=", value) }
      sku.active = self.values[:active] || false
  		sku.save
    end

  	def delete_stripe_sku
  		Stripe::SKU.retrieve(self.stripe_id).try(:delete)
  	end
  end
end
