module Devx
  class ProductSku < ActiveRecord::Base
  	belongs_to :product

  	after_create :create_stripe_sku
  	#after_destroy :delete_stripe_sku

  	private

  	def create_stripe_sku
  		product = Stripe::Product.retrieve(self.product.slug)

  		if self.stockable == true
  			inventory = 'finite'
  			quantity = 0
  		else
  			inventory = 'infinite'
  			quantity = nil
  		end

   		sku = Stripe::SKU.create(
   			:product => product.id,
		  	:price => (self.price * 100).to_i,
		   	:currency => self.currency,
		   	:inventory => {
		     	'type' => inventory,
     			'quantity' => quantity
		   	}
		 )

		 self.stripe_id = sku.id
		 self.save
  	end

	# def delete_stripe_sku
	# 	sku = Stripe::SKU.retrieve(self.stripe_id)
	#  	sku.delete
	# end

  end
end