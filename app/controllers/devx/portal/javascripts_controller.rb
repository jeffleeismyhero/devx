require_dependency "devx/application_controller"

module Devx
  class Portal::JavascriptsController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :javascript, class: 'Devx::Javascript'
  	layout 'devx/portal'

    def index
    end

    def edit
    end

    def new
    end

    def create
    	if @javascript.valid? && @javascript
    		redirect_to devx.edit_portal_javascript_path(@javascript),
    		notice: "Successfully saved javascript"
    	else
    		redirect_to devx.edit_portal_javascript_path(@javascript),
    		notice: "Failed to save javascript"
    	end
    end

    def update
    	if @javascript.valid? && @javascript.update(javascript_params)
    		redirect_to devx.edit_portal_javascript_path(@javascript),
    		notice: "Successfully updated javascript"
    	else
    		redirect_to devx.edit_portal_javascript_path(@javascript),
    		notice: "Failed to save javascript"
    	end
    end

    def destroy
    	if @javascript.destroy
    		redirect_to devx.edit_portal_javascript_path,
    		notice: "Successfully deleted javascript"
    	else
    		redirect_to devx.edit_portal_javascript_path,
    		notice: "Failed to delete javascript"
    	end
    end

    private

    def javascript_params
    	accessible = [ :name, :content ]
    	params.require(:javascript).permit(accessible)
    end
  end
end

