require_dependency "devx/application_controller"

module Devx
  class Portal::DashboardController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :dashboard, class: 'Devx::Dashboard'
    layout 'devx/portal'

    def index
    end
  end
end