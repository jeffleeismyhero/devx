require_dependency "devx/application_controller"

module Devx
  class Admin::DashboardController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :dashboard, class: 'Devx::Dashboard'
    layout 'devx/admin'

    def index
    end
  end
end
