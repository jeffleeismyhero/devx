require_dependency "devx/application_controller"

module Devx
  class Portal::SportsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :sport, class: 'Devx::Sport'
    layout 'devx/portal'

    def index
        @q = @sports.search(params[:q])
        @q.sorts = 'name asc' if @q.sorts.empty?
        @sports = @q.result(distinct: true)
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
        accessible = [ :name,
                      sport_teams_attributes: [ :id, :jersey_number, :person_id, :position, :height, :weight, :grade, :_destroy ] ]
        params.require(:sport).permit(accessible)
    end
  end
end
