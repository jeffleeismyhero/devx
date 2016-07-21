require_dependency "devx/application_controller"

module Devx
  class Portal::AccountTransactionsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :account_transaction, class: 'Devx::AccountTransaction'
    layout 'devx/portal'

    def index
      @q = @account_transactions.search(params[:q])
      @q.sorts = 'created_at desc' if @q.sorts.empty?

      if params[:q].present?
        @account_transactions = @q.result(distinct: true).page(params[:page])
      elsif params['approved'].present?
        @account_transactions = @account_transactions.approved.page(params[:page])
      else
        @account_transactions = @account_transactions.pending.page(params[:page])
      end
    end

    def process_transaction
      @account_transaction = Devx::AccountTransaction.find(params[:id])

      if request.post?
        if @account_transaction.processed_at.nil?
          @account_transaction.processed_at =  Time.zone.now
          @account_transaction.save
          redirect_to devx.portal_account_transactions_path,
          notice: "Successfully processed the transaction"
        end
      end
    end

    def process_all
      @account_transactions = Devx::AccountTransaction.pending

      @account_transactions.try(:each) do |transaction|
        transaction.processed_at = Time.zone.now
        transaction.save
      end
      redirect_to devx.portal_account_transactions_path,
      notice: "Successfully processed all transactions"
    end
  end
end
