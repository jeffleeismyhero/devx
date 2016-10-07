require_dependency "devx/application_controller"

module Devx
  class CartController < ApplicationController
    before_filter :authenticate_user!, only: :checkout
    load_resource :order, class: 'Devx::Order'
    layout :determine_layout

    def index
      @layout = Devx::Layout.find(app_settings['commerce_layout']) if app_settings['commerce_layout'].present?
      @page = Devx::Page.new(name: 'Cart', layout: @layout)

      if session[:cart] then
        @cart = session[:cart]

        ## Calculate subtotal
        @subtotal = calculate_subtotal(@cart)

      else
        @cart = {}
      end
    end

    def add
      id = params[:id]

      @sku = Devx::ProductSku.find(id)

      if @sku.present?

        #use the existing cart, otherwise if one doesn't exist then create a new cart
        if session[:cart] then
          cart = session[:cart]
        else
          session[:cart] = {}
          cart = session[:cart]
        end

        if cart[id] then
          cart[id] = cart[id] + 1
        else
          cart[id] = 1
        end
        redirect_to devx.cart_index_path,
        notice: "Added #{@sku.product.try(:name)} to cart"

      end

    rescue ActiveRecord::RecordNotFound
      redirect_to :action => :index
    end

    def empty
      session[:cart] = nil
      redirect_to devx.cart_index_path,
      notice: "Your cart is now empty"
    end

    def checkout
      @layout = Devx::Layout.find(app_settings['commerce_layout']) if app_settings['commerce_layout'].present?
      @page = Devx::Page.new(name: 'Cart', layout: @layout)

      if session[:cart]
        @cart = session[:cart]
      else
        @cart = {}
      end

      @order = Devx::Order.new

      if request.post? && session[:cart].present?
        stripe_source = params[:order][:stripe_token]

        if current_user.stripe_id.present?
          customer = Stripe::Customer.retrieve(current_user.stripe_id)
        else
          customer = Stripe::Customer.create(email: current_user.email, source: stripe_source)
          current_user.update_columns(stripe_id: customer.id)
        end

        @cart = session[:cart]

        order = params[:order]
        @order = Devx::Order.new({
          user: current_user,
          billing_address_1: order[:billing_address_1],
          billing_address_2: order[:billing_address_2],
          billing_address_city: order[:billing_address_city],
          billing_address_state: order[:billing_address_state],
          billing_address_zip_code: order[:billing_address_zip_code],
          shipping_address_1: order[:shipping_address_1],
          shipping_address_2: order[:shipping_address_2],
          shipping_address_city: order[:shipping_address_city],
          shipping_address_state: order[:shipping_address_state],
          shipping_address_zip_code: order[:shipping_address_zip_code]
        })

        @cart.try(:each) do |sku, qty|
          @order.line_items.new(product_sku_id: sku, quantity: qty)
        end


        if @order.valid? && @order.save
          session.delete(:cart)
          redirect_to devx.cart_index_path,
          notice: "Your order has been received."
        end
      end
    end


    private

    def determine_layout
      if app_settings['commerce_layout'].present?
        'devx/custom'
      else
        'devx/application'
      end
    end

    def calculate_subtotal(cart)
      subtotal = 0
      cart.each do |key, value|
        subtotal += (Devx::ProductSku.find(key).price * value)
      end
      return subtotal
    end
  end
end
