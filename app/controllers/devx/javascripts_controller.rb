require_dependency "devx/application_controller"

module Devx
  class JavascriptsController < ApplicationController
  	load_and_authorize_resource :javascript, class: 'Devx::Javascript'

    def show
    	respond_to do |format|
<<<<<<< HEAD:app/controllers/devx/javascripts_controller.rb
        format.javascript { render text: @javascript.content, content_type: 'javascript' }
=======
    		format.javascript { render text: @javascript.content, content_type: 'text/javascript'}
    	end
>>>>>>> origin/master:app/controllers/devx/javascripts_controller.rb
    end
  end
end