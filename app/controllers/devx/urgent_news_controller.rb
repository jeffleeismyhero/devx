require_dependency "devx/application_controller"

module Devx
  class UrgentNewsController < ApplicationController
  	load_resource :urgent_news, class: 'Devx::UrgentNews'
  	
    def show
    end
  end
end
