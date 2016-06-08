require_dependency "devx/application_controller"

module Devx
  class Portal::ExtracurricularsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource

    layout 'portal'

    def index
        @extracurriculars = @extracurriculars.order.paginate(page: params[:page], per_page: 10)
    end

    def new
    end

    def edit
    end

    def show
    end

    def create
        if @extracurricular.save
            redirect_to portal_extracurriculars_path
            notice: 'Successfully added extracurricular'
        else
            render :new,
            notice: 'Failed to save extracurricular'
        end
    end

    def update
        if @extracurricular.update(extracurricular_params)
            redirect_to portal_extracurriculars_path
            notice: 'Successfully updated extracurricular'
        else
            render :edit,
            notice: 'Failed to save extracurricular'
        end
    end

    def destroy
    end

    def extracurricular_params
        accessible = [ :name, :description, :image ]
        params.require(:extracurricular).permit(accessible)
    end
  end
end
