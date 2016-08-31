require_dependency "devx/application_controller"

module Devx
  class Portal::FormsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :form, class: 'Devx::Form'
    load_and_authorize_resource :form_submission, class: 'Devx::FormSubmission'
    layout 'devx/portal'

    def index
    end

    def new
    end

    def edit
    end

    def show
      @fields = []
      @form.fields.order(position: :asc).try(:each) do |field|
        @fields << field.name
      end

      respond_to do |format|
        format.html
        format.xlsx do
          render xlsx: 'show', filename: "#{@form.name} - Submissions.xlsx"
        end
      end
    end

    def create
      if @form.valid? && @form.save
        redirect_to devx.edit_portal_form_path(@form),
        notice: "Successfully saved form"
      else
        render :new,
        notice: "Failed to save form"
      end
    end

    def update
      if @form.valid? && @form.update(form_params)
        redirect_to devx.edit_portal_form_path(@form),
        notice: "Successfully updated form"
      else
        render :new,
        notice: "Failed to update form"
      end
    end

    def destroy
    end

    def sort
      list = params[:field]
      list.try(:each_with_index) do |id, index|
        Devx::Field.find(id).update_columns(position: index + 1)
      end
      render json: nil, status: :ok
    rescue
    end

    def submissions
      @form = Devx::Form.find(params[:id])
    end


    private

    def form_params
      accessible = [ :name, :image, :layout_id, :submission_recipients, fields_attributes: [ :id, :name, :field_type, :options, :field_size, :required, :_destroy ] ]
      params.require(:form).permit(accessible)
    end
  end
end
