require_dependency "devx/application_controller"

module Devx
  class Portal::DocumentsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :document, class: 'Devx::Document'
    layout 'devx/portal'

    def index
    end

    def create
      @document.name = @document.file.filename

      if @document.valid? && @document.save
        respond_to do |format|
          format.json{ render json: @document }
        end
      end
    end

    def destroy
      if @document.destroy
        redirect_to devx.portal_documents_path,
        notice: "Successfully deleted document"
      else
        redirect_to devx.portal_documents_path,
        notice: "Failed to delete document"
      end
    end


    private

    def document_params
      accessible = [ :name, :file ]
      params.require(:document).permit(accessible)
    end
  end
end
