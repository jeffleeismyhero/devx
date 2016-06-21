require_dependency "devx/application_controller"

module Devx
  class Portal::ProductsController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :product, class: 'Devx::Product', except: :show

    def index
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
            redirect_to dev.edit_portal_product_path(@product),
            notice: "Successfully updated product"
        else
            render :edit,
            notice: "Failed to save product"
        end
    end

    def destroy
        if @product.destroy
            redirect_to devx.portal_products_path,
            notice: "Successfully deleted product"
        end
    end

    private

    def product_params
        accessible = [ :name, :description, :sku, :price, :weight, :taxable, :stockable, :image ]
        params.require(:product).permit(accessible)
    end
  end
end
