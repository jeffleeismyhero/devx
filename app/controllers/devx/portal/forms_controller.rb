require_dependency "devx/application_controller"

module Devx
  class Portal::FormsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :form, class: 'Devx::Form'
    load_and_authorize_resource :registration, class: 'Devx::Registration'
    layout 'devx/portal'

    def index
    end

    def new
    end

    def edit
    end

    def create
      @form.registration_id = params[:registration_id]
      
      if @form.valid? && @form.save
        redirect_to devx.edit_portal_registration_form_path(@registration, @form),
        notice: "Successfully saved form"
      else
        render :new,
        notice: "Failed to save form"
      end
    end

    def update
      @form.registration_id = params[:registration_id]
      
      if @form.valid? && @form.update(form_params)
        redirect_to devx.edit_portal_registration_form_path(@registration, @form),
        notice: "Successfully updated form"
      else
        render :new,
        notice: "Failed to update form"
      end
    end

    def destroy
    end

    
    private

    def form_params
      accessible = [ :name, :image, :registration_id, fields_attributes: [ :id, :form_id, :name, :field_type, :field_size, :required, :_destroy ] ]
      params.require(:form).permit(accessible)
    end 
  end
end
