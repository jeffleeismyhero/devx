require_dependency "devx/application_controller"

module Devx
  class Portal::AccountTransactionsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :account_transaction, class: 'Devx::AccountTransaction'
    layout 'devx/portal'

    def index
      @q = @account_transactions.search(params[:q])
      @q.sorts = 'created_at desc' if @q.sorts.empty?
      @account_transactions = @q.result(distinct: true).page(params[:page])
    end
  end
end
