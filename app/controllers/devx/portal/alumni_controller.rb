require_dependency "devx/application_controller"

module Devx
  class Portal::AlumniController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :alumni, class: 'Devx::Alumni'
    layout 'devx/portal'

    def index
    end

    def show
    end

    def edit
    end

    def new
    end

    def create
    end

    def update
    end

    def destroy
    end


    private

    def alumni_params
      accessible = []
    end
  end
end
