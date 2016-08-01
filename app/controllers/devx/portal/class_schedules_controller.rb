require_dependency "devx/application_controller"

module Devx
  class Portal::ClassSchedulesController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :class_schedule, class: 'Devx::ClassSchedule'

  	layout 'devx/portal'

  	def index
  	end

  	def new
  	end

  	def create
  		if @class_schedule.valid? && @class_schedule.save
  			redirect_to devx.portal_class_schedule_path(@class_schedule),
  			notice: "Class schedule has been successfully created."
  		else
  			render :new,
  			notice: "Class schedule failed to create."
  		end
  	end

  	def edit
  	end

  	def update
  		if @class_schedule.valid? && @class_schedule.save
  			redirect_to devx.portal_class_schedule_path(class_schedule_params),
  			notice: "Class schedule was successfully updated."
  		else
  			render :edit,
  			notice: "Class schedule failed to update."
  		end
  	end

  	def show
  	end

  	def destroy
  		if @class_schedule.destroy
  			redirect_to devx.portal_class_schedules_path,
  			notice: "Class schedule has been successfully deleted."
  		else
  			redirect_to devx.portal_class_schedules_path,
  			notice: "Class schedule failed to delete."
  		end
  	end

  	private

  	def class_schedule_params
  		accessible = [:name, :description, :start_time, :end_time]
  		params.require(:class_schedule).permit(accessible)
  	end

  end
end
