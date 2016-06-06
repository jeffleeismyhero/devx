require_dependency "devx/application_controller"

module Devx
  class Portal::OrdersController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :order, class: 'Devx::Order'

    def index
    end

    def new
    end

    def edit
    end

    def create
      if @order.save
        redirect_to devx.edit_portal_order_path(@order),
        notice: "Successfully created #{@order}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @order.update(order_params)
        redirect_to devx.edit_portal_order_path(@order),
        notice: "Successfully updated #{@order}"
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


    private

    def order_params
      accessible = [ :user_id,
                    transactions_attributes: [ :id, :order_id, :payment_method, :amount, :comments, :_destroy ]
                  ]
      params.require(:order).permit(accessible)
    end
  end
end
