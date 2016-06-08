require_dependency "devx/application_controller"

module Devx
  class Portal::MembersController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :member, class: 'Devx::Member'
    layout 'devx/portal'

    def index
    end

    def edit
    end

    def new
    end

    def create
      if @member.valid? && @member.save
        redirect_to devx.portal_members_path,
        notice: "Successfully saved member"
      else
        render :new,
        notice: "Failed to save member"
      end
    end

    def update
      if @member.valid? && @member.update(member_params)
        redirect_to devx.portal_members_path,
        notice: "Successfully updated member"
      else
        render :new,
        notice: "Failed to update member"
      end
    end

    def destroy
      if @member.destroy
        redirect_to devx.portal_members_path,
        notice: "Successfully deleted member"
      else
        redirect_to devx.portal_members_path,
        notice: "Failed to delete member"
      end
    end


    private

    def member_params
      accessible = [ :first_name, :last_name, :position, :department, :address,
        :city, :state, :zip, :phone, :email, :website, :photo, :biography ]
      params.require(:member).permit(accessible)
    end
  end
end
