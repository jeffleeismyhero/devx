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
        if @product.valid? && @product.update(product_params)
            redirect_to devx.edit_portal_product_path(@product),
            notice: "Successfully updated product"
        else
            render :edit,
            notice: "Failed to save product"
        end
     rescue Stripe::InvalidRequestError
        render :edit,
        notice: "Ensure that this product matches the product details in Stripe."
    end

    def destroy
        if @product.destroy
            redirect_to devx.portal_products_path,
            notice: "Successfully deleted product"
        end
    end

    private

    def product_params
        accessible = [ :name, :description, :active, :sku, :price, :weight, :taxable, :stockable, :image, :shippable, product_skus_attributes: [ :id, :currency, :price, :stockable, :active, :_destroy ] ]
        params.require(:product).permit(accessible)
    end
  end
end
