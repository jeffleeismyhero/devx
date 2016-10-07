require_dependency "devx/application_controller"

module Devx
  class Portal::OrdersController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :order, class: 'Devx::Order'

    def index
      @q = @orders.search(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @orders = @q.result(distinct: true)

      respond_to do |format|
        format.html
        format.xlsx do
          render xlsx: 'index', filename: 'order_export.xlsx'
        end
      end
    end

    def show
    end

    def new
      @users = Devx::User.all
      @products = Devx::Product.all
    end

    def edit
      @users = Devx::User.all
      @products = Devx::Product.all
    end

    def create
      @users = Devx::User.all
      @products = Devx::Product.all

      if @order.valid? && @order.save
        redirect_to devx.portal_order_path(@order),
        notice: "Successfully created #{@order.id}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      @users = Devx::User.all
      @products = Devx::Product.all

      if order_params.include?('transactions_attributes')
        if order_params['transactions_attributes']['0']['amount'].to_f > @order.balance
          redirect_to devx.portal_order_path(@order),
          notice: "The payment amount cannot be higher than the balance"
          return
        end
      end

      if @order.update(order_params)
        redirect_to devx.portal_order_path(@order),
        notice: "Successfully updated #{@order.id}"
      else
        render :edit,
        notice: 'An error occurred'
      end
    end

    def destroy
      if @order.destroy
        redirect_to devx.portal_orders_path,
        notice: "Successfully deleted #{@order.id}"
      else
        render :index,
        notice: 'An error occurred'
      end
    end

    def refund
      if @order.refund_through_stripe
        redirect_to devx.portal_orders_path,
        notice: "Successfully refunded order #{@order.id}"
      else
        redirect_to devx.portal_order_path(@order),
        notice: "Failed to refund order #{@order.id}"
      end
    end


    private

    def order_params
      accessible = [ :user_id,
                    line_items_attributes: [ :id, :product_id, :quantity, :_destroy ],
                    transactions_attributes: [ :id, :payment_method, :amount, :comments, :_destroy ]
                  ]
      params.require(:order).permit(accessible)
    end
  end
end
