require_dependency "devx/application_controller"

module Devx
  class JavascriptsController < ApplicationController
  	load_and_authorize_resource :javascript, class: 'Devx::Javascript'

    def show
    	respond_to do |format|
    		format.javascript { render text: @javascript.content, content_type: 'javascript'}
    	end
    end
  end
end



