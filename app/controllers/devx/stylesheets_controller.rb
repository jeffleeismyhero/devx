require_dependency "devx/application_controller"

module Devx
  class StylesheetsController < ApplicationController
    load_resource :stylesheet, class: 'Devx::Stylesheet'

    def show
      respond_to do |format|
        format.css { render text: YUI::CssCompressor.new.compress(@stylesheet.content), content_type: 'text/css' }
      end
    end
  end
end
