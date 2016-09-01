module Devx
  class ProductSku < ActiveRecord::Base
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
  		sku = product.skus.create(values)
      update_attributes(stripe_id: sku.id)
  	end

  	def delete_stripe_sku
  		Stripe::SKU.retrieve(self.stripe_id).try(:delete)
  	end
  end
end
