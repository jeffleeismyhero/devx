require_dependency "devx/application_controller"

module Devx
  class Portal::ClassDocumentsController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :class_document, class: 'Devx::ClassDocument'
    load_and_authorize_resource :classroom, class: 'Devx::Classroom'

  	layout 'devx/portal'

  	def index
      @class_documents = Devx::ClassDocument.where(classroom: @classroom)
  	end

  	def new
  	end

  	def create

      @class_document.classroom = @classroom

  		if @class_document.valid? && @class_document.save
  			redirect_to devx.portal_classroom_class_documents_path,
  			notice: "Class document was successfully created."
  		else
  			render :new,
  			notice: "Class document failed to create."
  		end
  	end

  	def edit
  	end

  	def update
  		if @class_document.valid? && @class_document.update(class_document_params)
  			redirect_to devx.edit_portal_classroom_class_document_path(@classroom, @class_document),
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
  			redirect_to devx.portal_classroom_class_documents_path,
  			notice: "Class document was successfully deleted."
  		else
  			redirect_to devx.portal_classroom_class_documents_path,
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
