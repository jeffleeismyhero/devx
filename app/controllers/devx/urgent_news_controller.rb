require_dependency "devx/application_controller"

module Devx
  class UrgentNewsController < ApplicationController
  	load_and_authorize_resource
  	
    def show
    end
  end
end
