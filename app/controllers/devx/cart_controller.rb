require_dependency "devx/application_controller"

module Devx
  class CartController < ApplicationController
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
        redirect_to :action => :index

      end

    rescue ActiveRecord::RecordNotFound
      redirect_to :action => :index
    end

    def empty
      session[:cart] = nil
      redirect_to :action => :index
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

      if request.post?
        stripe_source = params[:order][:stripe_token]

        if session[:cart]
          @cart = session[:cart]
        else
          @cart = {}
        end

        line_items = []

        if current_user.stripe_id.present?
          customer = Stripe::Customer.retrieve(stripe_id)
        else
          customer = Stripe::Customer.create(email: current_user.email, source: stripe_source)
          current_user.update_columns(stripe_id: customer.id)
        end

        @cart.each do |line_item, quantity|
          sku = Devx::ProductSku.find(line_item)
          line_items << { type: 'sku', parent: sku.stripe_id, quantity: quantity, description: sku.product.name, amount: sku.price_in_cents }
        end

        order = Stripe::Order.create(
        currency: 'usd',
        customer: customer.id,
        items: line_items
        )

        order.pay(customer: customer)
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
