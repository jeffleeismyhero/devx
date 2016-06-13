#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller"

module Devx
  class Portal::UsersController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
  	#initializes instance variables. ( e.g. index uses @users = User.all, show uses @user = User.find(params[:id]) )
  	load_and_authorize_resource :user, class: 'Devx::User'
  	
  	def index
      respond_to do |format|
        format.html
        format.xlsx do
          render xlsx: 'index', filename: 'users.xlsx'
        end
      end
  	end
  	
  	def show
  	end
  	
  	def new
  	end
  	
  	def edit
  	end

  	def create
  		if @user.valid? && @user.save
  			redirect_to devx.edit_portal_user_path(@user),
  			notice: "Successfully saved user"

  		else
  			render :new,
  			notice: "Failed to save user"
  		end
  	end

  	def update
  		if @user.valid? && @user.update(user_params)
  			redirect_to devx.edit_portal_user_path(@user),
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

    def account_deposit

      @transaction = AccountTransaction.new

      if request.post?
        @transaction.amount = params[:account_transaction][:amount]
        @transaction.transaction_type = 'Credit'
        @transaction.payment_method = 'Credit Card'
        @transaction.user = @user

        exp_date = "#{params[:exp_month]}#{params[:exp_year]}"
        if PayeezyTransaction.process(@transaction.amount.to_i, params[:cc_type], params[:ch_name], params[:cc_number], exp_date, params[:cvv])
          if @transaction.save
            flash.now[:success] = 'Your transaction has been processed successfully'
            redirect_to devx.account_deposit_portal_user_path(@user)
          else
            flash.now[:alert] = 'Transaction was complete but the balance could not be updated'
            redirect_to devx.account_deposit_portal_user_path(@user)
          end
        else
          flash.now[:alert] = 'Your transaction could not be processed'
          render :account_deposit
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
                user.save
              else
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
  			accessible = [ :email, :first_name, :last_name, role_ids: [],
                      children_attributes: [ :id, :first_name, :last_name, :_destroy ]
                    ]

  			#adds the below params to the above var except when the user and password fields are blank
  			accessible  << [ :password, :password_confirmation ] unless params[:user][:password].blank?

  			params.require(:user).permit(accessible)
  		end

  end
end
