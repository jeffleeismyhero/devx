#auto generated when controller is created due to devx being a gem
require_dependency "devx/application_controller"

module Devx
  class Portal::UsersController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
  	#initializes instance variables. ( e.g. index uses @users = User.all, show uses @user = User.find(params[:id]) )
  	load_and_authorize_resource :user, class: 'Devx::User'
  	
  	def index
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
