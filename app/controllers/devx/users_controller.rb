require_dependency "Devx/application_controller"

module Devx
  class UsersController < ApplicationController
    load_and_authorize_resource

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
        redirect_to users_path,
        notice: "Successfully saved user"
      else
        render :new,
        notice: "Failed to save user"
      end
    end

    def update
      if @user.valid? && @user.update(user_params)
        redirect_to users_path,
        notice: "Successfully updated user"
      else
        render :edit,
        notice: "Failed to update user"
      end
    end

    def destroy
      if @user.destroy
        redirect_to users_path,
        notice: "Successfully deleted user"
      end
    end


    private

    def user_params
      accessible = [ :email, :first_name, :last_name ]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
  end
end
