require_dependency "devx/application_controller"

module Devx
  class Portal::ProductsController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :product, class: 'Devx::Product', except: :show

    def index
        @q = @products.search(params[:q])
        @q.sorts = 'name asc' if @q.sorts.empty?
        @products = @q.result(distinct: true)
    end

    def new
    end

    def edit
    end

    def create
        if @product.valid? && @product.save
            redirect_to devx.edit_portal_product_path(@product),
            notice: "Successfully saved product"
        else
            render :new,
            notice: "Failed to save product"
        end
    end

    def update
        update_product_sku_attributes
        if @product.valid? && @product.update(product_params)
            redirect_to devx.edit_portal_product_path(@product),
            notice: "Successfully updated product"
        else
            render :edit,
            notice: "Failed to save product"
        end
        #rescue Stripe::InvalidRequestError
        #render :edit,
        #notice: "Ensure that this product matches the product details in Stripe."
    end

    def destroy
        if @product.destroy
          redirect_to devx.portal_products_path,
          notice: "Successfully deleted product"
        else
          redirect_to devx.portal_products_path,
          notice: "An error is preventing this product from being deleted."
        end
    end

    private

    def product_params
        accessible = [  :name, :description, :active, :sku, :price, :weight, :taxable, :stockable, 
                        :image, :shippable, product_skus_attributes: [ :id, :currency, :price, :stockable, :active, :_destroy ], 
                        product_attributes_attributes: [ :id, :product_attribute, :_destroy ], product_sku_attributes_attributes: [ :id, :value, :_destroy ] ]
        params.require(:product).permit(accessible)
    end

    def update_product_sku_attributes
        attributes = params[:product_sku_attributes]

        @product.product_skus.try(:each) do |sku|
            attributes.try(:each) do |key, value|
                sku.product_sku_attributes.new(product_attribute_id: key, value: value)
            end
        end
    end
  end
end
