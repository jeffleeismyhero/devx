require_dependency "devx/application_controller"

module Devx
  class Portal::ProductSkusController < ApplicationController
  	before_filter :authenticate_user!
  	layout 'devx/portal'
    load_and_authorize_resource :product_sku, class: 'Devx::ProductSku', except: :show
  	load_and_authorize_resource :product, class: 'Devx::Product'

  	def index
      @product_skus = Devx::ProductSku.where(product: @product)
  	end

  	def new
  	end

  	def edit
  	end

  	def create
      @product_sku.product = @product
      set_attributes

  		if @product_sku.valid? && @product_sku.save
  			redirect_to devx.edit_portal_product_product_sku_path(@product, @product_sku),
  			notice: "SKU was successfully saved"
  		else
  			render :new,
  			notice: "Sku failed to save"
  		end
  	end

  	def update
      set_attributes

  		if @product_sku.valid? && @product_sku.update(product_sku_params)
  			redirect_to devx.edit_portal_product_product_sku_path(@product, @product_sku),
  			notice: "SKU was successfully updated"
  		else
  			render :edit,
  			notice: "SKU failed to update"
  		end
  	end

  	def destroy
  		if @product_sku.destroy
  			redirect_to devx.portal_product_product_skus_path(@product),
  			notice: "SKU was successfully deleted"
  		else
  			redirect_to devx.portal_product_product_skus_path(@product),
  			notice: "An error is preventing this SKU from being deleted"
  		end
  	end

  	private

  	def product_sku_params
  		accessible = [ :currency, :price, :stockable, :active ]
  		params.require(:product_sku).permit(accessible)
  	end

    def set_attributes
      params['product_sku_attributes'].try(:each) do |key, value|
        attribute = Devx::ProductSkuAttribute.find_by(product_sku: @product_sku, product_attribute_id: key)

        if attribute.nil?
          @product_sku.product_sku_attributes.new(product_attribute_id: key, value: value)
        else
          attribute.update_columns(value: value)
        end
      end
    end
  end
end