require_dependency "devx/application_controller"

module Devx
  class DocumentsController < ApplicationController
    load_resource :document, class: 'Devx::Document'
  end
end
