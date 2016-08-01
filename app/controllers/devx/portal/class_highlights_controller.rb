require_dependency "devx/application_controller"

module Devx
  class Portal::ClassHighlightsController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :class_highlight, class: 'Devx::ClassHighlight'

  	layout 'devx/portal'

  	def index
  	end

  	def new
  	end

  	def create
  		if @class_highlight.valid? && @class_highlight.save
  			redirect_to devx.portal_class_highlight_path(@class_highlight),
  			notice: "Class highlight was successfully created."
  		else
  			render :new,
  			notice: "Class highlight failed to create."
  		end
  	end

  	def edit
  	end

  	def update
  		if @class_highlight.valid? && @class_highlight.update
  			redirect_to devx.portal_class_highligh_path(class_highlight_params),
  			notice: "Class highlight was successfully updated."
  		else
  			render :edit,
  			notice: "Class highlight failed to update."
  		end
  	end

  	def show
  	end

  	def destroy
  		if @class_highlight.destroy
  			redirect_to devx.portal_class_highlights_path,
  			notice: "Class highlight was successfully deleted."
  		else
  			redirect_to devx.portal_class_highlights_path,
  			notice: "Class highlight failed to delete."
  		end
  	end

  	private

  	def class_highlight_params
  		accessible = [:title, :content, :image]
  		params.require(:class_highlight).permit(accessible)
  	end

  end
end
