require_dependency "devx/application_controller"

module Devx
  class Portal::AdministrationController < ApplicationController
    before_filter :authenticate_user!
    layout 'devx/portal'
    load_and_authorize_resource :administration, class: 'Devx::Person'

    def index
      @q = @administrations.search(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @administrations = @q.result(distinct: true)
    end

    def new
    end

    def edit
    end

    def create
      if @administration.valid? && @administration.save
        redirect_to devx.portal_administration_index_path,
        notice: "Successfully created #{@administration.try(:full_name)}"
      else
        render :new,
        notice: 'An error occurred'
      end
    end

    def update
      if @administration.valid? && @administration.update(administration_params)
        redirect_to devx.portal_administration_index_path,
        notice: "Successfully updated #{@administration.try(:full_name)}"
      else
        render :edit,
        notice: 'An error occurred'
      end
    end

    def destroy
      if @administration.destroy
        redirect_to devx.portal_administration_index_path,
        notice: "Successfully deleted #{@administration.try(:full_name)}"
      else
        render :index,
        notice: 'An error occurred'
      end
    end


    private

    def administration_params
      accessible = [ :uuid, :prefix, :first_name, :last_name, :suffix, :gender, :birthdate, :address, :city, :state, :zip, :email, :phone, :mobile_number, :association_list, :active ]
      params.require(:person).permit(accessible)
    end
  end
end
