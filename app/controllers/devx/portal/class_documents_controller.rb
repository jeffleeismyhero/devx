require_dependency "devx/application_controller"

module Devx
  class Portal::ClassDocumentsController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :class_document, class: 'Devx::ClassDocument'

  	layout 'devx/portal'

  	def index
  	end

  	def new
  	end

  	def create
  		if @class_document.valid? && @class_document.save
  			redirect_to devx.portal_class_document_path(@class_document),
  			notice: "Class document was successfully created."
  		else
  			render :new,
  			notice: "Class document failed to create."
  		end
  	end

  	def edit
  	end

  	def update
  		if @class_document.valid? && @class_document.save
  			redirect_to devx.portal_class_document_path(class_document_params),
  			notice: "Class document was successfully updated."
  		else
  			render :edit,
  			notice: "Class document failed to update."
  		end
  	end

  	def show
  	end

  	def destroy
  		if @class_document.destroy
  			redirect_to devx.portal_class_documents_path,
  			notice: "Class document was successfully deleted."
  		else
  			redirect_to devx.portal_class_documents_path,
  			notice: "Class document failed to delete."
  		end
  	end

  	private

  	def class_document_params
  		accessible = [:name, :filename]
  		params.require(:class_document).permit(accessible)
  	end

  end
end
