#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller"

module Devx
  class Portal::UsersController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
  	#initializes instance variables. ( e.g. index uses @users = User.all, show uses @user = User.find(params[:id]) )
  	load_and_authorize_resource :user, class: 'Devx::User'
  	
  	def index
      @q = @users.search(params[:q])
      @q.sorts = 'last_name asc, first_name asc' if @q.sorts.empty?
      @users = @q.result(distinct: true)

      respond_to do |format|
        format.html
        format.xlsx do
          render xlsx: 'index', filename: 'users_export.xlsx'
        end
      end
  	end
  	
  	def show
      @user ||= current_user
  	end
  	
  	def new
  	end
  	
  	def edit
  	end

  	def create
  		if @user.valid? && @user.save
  			redirect_to devx.portal_user_path(@user),
  			notice: "Successfully saved user"

  		else
  			render :new,
  			notice: "Failed to save user"
  		end
  	end

  	def update
  		if @user.valid? && @user.update(user_params)
  			redirect_to devx.portal_user_path(@user),
  			notice: "Successfully updated user"

  		else
  			render :new,
  			notice: "Failed to update user"
  		end
  	end

  	def destroy
  		if @user.destroy
  			redirect_to devx.portal_users_path,
  			notice: "Successfully deleted user"
  		end
  	end

    def account_balance
      @user ||= current_user

      @linked_accounts = {}

      if @user.person_id.present?
        @linked_accounts[@user.person_id] = @user.person.try(:record_with_school_id)
      end

      @user.linked_accounts.try(:each) do |linked_account|
        @linked_accounts[linked_account.person.id] = linked_account.person.try(:record_with_school_id)
      end

      @account_transactions = Devx::AccountTransaction.where(person: @user.person)

      @transaction = AccountTransaction.new

      if request.post?
        @transaction.amount = params[:account_transaction][:amount]
        @transaction.transaction_type = 'Credit'
        @transaction.payment_method = 'Credit Card'
        @transaction.person_id = params[:account_transaction][:person_id]
        @transaction.cardholder = params[:ch_name]

        exp_date = "%02d%02d" % [params['expiry_date(2i)'], params['expiry_date(1i)'].last(2)]

        if @transaction.valid?
          if @transaction.process(@transaction.amount.to_i, params[:cc_type], params[:ch_name], params[:cc_number], exp_date, params[:cvv])
            if @transaction.save
              redirect_to devx.portal_account_balance_path,
              notice: "Your transaction has been processed successfully"
            else
              redirect_to devx.portal_account_balance_path,
              notice: "Transaction was complete but the balance could not be updated"
            end
          else
            render :account_balance,
            notice: "Your transaction could not be processed"
          end
        end
      end
    end

    def import
      require 'csv'

      @import = Devx::Import.new(params[:import])
      @errors = 0;

      if request.post?

        if @import.valid?

          puts @import.inspect

          if records = CSV.read(@import.file.path, headers: true)
            logfile = File.open("#{Rails.root}/log/import.log", "a")
            logfile.sync = true
            logger = Logger.new(logfile)
            
            records.each_with_index do |record, index|
              first_name = record[0].to_s.squish
              last_name = record[1].to_s.squish
              email = record[2].to_s.squish
              password = record[3].to_s.squish

              user = Devx::User.new(
                first_name: first_name,
                last_name: last_name,
                email: email,
                password: password,
              )

              puts user.inspect

              if user.valid?
                logger.info "Expecting object to be valid: #{article.inspect}"
                user.save
              else
                logger.warn "Failed to import object: #{article.inspect}"
                article.errors.full_messages.try(:each) do |error|
                  logger.warn "#{error}"
                end
                @errors += 1
              end
            end
          end
        end
          redirect_to devx.portal_users_path,
          notice: "#{@errors} users could not be imported due to errors"
      end
    end

    def import_transactions
      require 'csv'

      @import = Devx::Import.new(params[:import])
      @errors = 0;

      if request.post?

        if @import.valid?

          if records = CSV.read(@import.file.path, headers: true)
            logfile = File.open("#{Rails.root}/log/import.log", "a")
            logfile.sync = true
            logger = Logger.new(logfile)
            
            records.each_with_index do |record, index|
              created_at = record[0].to_s.squish
              receipt_number = record[1].to_s.squish
              transaction_type = record[2].to_s.squish
              payment_method = record[3].to_s.squish
              upc = record[4].to_s.squish
              product = record[5].to_s.squish
              amount = record[6].to_s.squish

              user = Devx::User.new(
                created_at: created_at,
                receipt_number: receipt_number,
                transaction_type: transaction_type,
                payment_method: payment_method,
                upc: upc,
                product: product,
                amount: amount,
              )

              puts user.inspect

              if user.valid?
                logger.info "Expecting object to be valid: #{article.inspect}"
                user.save
              else
                logger.warn "Failed to import object: #{article.inspect}"
                article.errors.full_messages.try(:each) do |error|
                  logger.warn "#{error}"
                end
                @errors += 1
              end
            end
          end
        end
          redirect_to devx.portal_users_path,
          notice: "#{@errors} users could not be imported due to errors"
      end
    end

  	private

  		def user_params
  			accessible = [ :person_id, :email, :first_name, :last_name, :generate_password, :photo, role_ids: [],
                      children_attributes: [ :id, :first_name, :last_name, :_destroy ],
                      linked_accounts_attributes: [ :id, :user_id, :person_id, :_destroy ]
                    ]

  			#adds the below params to the above var except when the user and password fields are blank
  			accessible  << [ :password, :password_confirmation ] unless params[:user][:password].blank?

  			params.require(:user).permit(accessible)
  		end

  end
end
