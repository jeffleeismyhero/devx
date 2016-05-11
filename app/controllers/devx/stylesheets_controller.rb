require_dependency "devx/application_controller"

module Devx
  class StylesheetsController < ApplicationController
    load_and_authorize_resource :stylesheet, class: 'Devx::Stylesheet'

    def show
      respond_to do |format|
        format.css { render text: @stylesheet.content, content_type: 'text/css' }
      end
    end
  end
end
