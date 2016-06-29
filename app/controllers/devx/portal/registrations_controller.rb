require_dependency "devx/application_controller"

module Devx
  class Portal::RegistrationsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :registration, class: 'Devx::Registration'
    layout 'devx/portal'

    def index
    end

    def new
    end

    def edit
    end

    def show
    end

    def create
      if @registration.valid? && @registration.save
        redirect_to devx.portal_registration_path(@registration),
        notice: "Successfully saved registration"
      else
        redirect_to devx.portal_registration_path(@registration),
        notice: "Failed to save registration"
      end
    end

    def update
      if @registration.valid? && @registration.update(registration_params)
        redirect_to devx.portal_registration_path(@registration),
        notice: "Successfully updated registration"
      else
        redirect_to devx.portal_registration_path(@registration),
        notice: "Failed to update registration"
      end
    end

    def destroy
      if @registration.destroy
        redirect_to devx.portal_registrations_path,
        notice: "Successfully deleted registration"
      else
        redirect_to devx.portal_registrations_path,
        notice: "Failed to delete registration"
      end
    end

    def enroll
      if params[:child].present?
        @registration.enroll(params[:child])
      end

      redirect_to devx.portal_registration_path(@registration)
    end

    def attendance
      if @registration.record_attendance(params[:child_id])
        redirect_to devx.portal_registration_path(@registration)
      end
    end

    def attendance_report
      @child = Devx::Child.find(params[:child_id])
      @attendances = @registration.attendance(@child)
    end


    private

    def registration_params
      accessible = [ :name, :cost, :submission_recipients ]
      params.require(:registration).permit(accessible)
    end
  end
end
