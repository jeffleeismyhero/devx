require_dependency "devx/application_controller"

module Devx
  class Portal::SportsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :sport, class: 'Devx::Sport'
    layout 'devx/portal'

    def index
    end

    def new
    end

    def edit
    end

    def create
        if @sport.save
            redirect_to portal_sports_path
        else
            render :new,
            notice: 'Failed to create sport'
        end
    end

    def update
        if @sport.update(sport_params)
            redirect_to portal_sports_path
        else
            render :new,
            notice: 'Failed to create sport'
        end
    end

    def destroy
        if @sport.destroy
            redirect_to portal_sports_path
        end
    end

    def sport_params
        accessible = [ :name ]
        params.require(:sport).permit(accessible)
    end
  end
end


