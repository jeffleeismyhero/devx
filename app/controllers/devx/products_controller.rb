require_dependency "devx/application_controller"

module Devx
  class ProductsController < ApplicationController
    load_resource :product, class: 'Devx::Product'
    layout :set_layout

  	def index
      if app_settings['commerce_layout'].present?
        @layout = Devx::Layout.find(app_settings['commerce_layout'])
      else
        @layout = nil
      end

      @page = Devx::Page.new(name: 'Shop', layout: @layout)

      @products = Devx::Product.active
      @q = @products.search(params[:q])
      @products = @q.result(distinct: true)
  	end

  	def show
      if app_settings['commerce_layout'].present?
        @layout = Devx::Layout.find(app_settings['commerce_layout'])
      else
        @layout = nil
      end

      @page = Devx::Page.new(name: @product.name, layout: @layout)
  	end


    private

    def set_layout
      if app_settings['commerce_layout'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end
  end
end
