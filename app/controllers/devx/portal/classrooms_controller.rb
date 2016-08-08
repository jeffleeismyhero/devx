require_dependency "devx/application_controller"

module Devx
  class Portal::ClassroomsController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :classroom, class: 'Devx::Classroom'
    layout 'devx/portal'


  	def index
  	end

  	def new
  	end

  	def create
  		if @classroom.valid? && @classroom.save
  			redirect_to devx.portal_classroom_path(@classroom),
  			notice: "Classroom has been successfully created."
  		else
  			render :new,
  			notice: "Classroom failed to create."
  		end
  	end

  	def edit
  	end

  	def update
  		if @classroom.valid? && @classroom.update(classroom_params)
  			redirect_to devx.portal_classroom_path(@classroom), 
  			notice: "Classroom has been successfully updated."
  		else
  			render :edit, 
  			notice: "Classroom failed to updated."
  		end
  	end

  	def show
      @page = Devx::Page.new(name: @classroom.name, layout: Devx::Layout.new(content: '{{page_content}}'))
  	end

  	def destroy
  		if @classroom.destroy
  			redirect_to devx.portal_classrooms_path,
  			notice: "Classroom has been successfully deleted."
  		else
  			redirect_to devx.portal_classrooms_path,
  			notice: "Classroom failed to delete."
  		end
  	end

  	private

  	def classroom_params
  		accessible = [ :name, :welcome_message, :policies_and_procedures, :layout_id, classroom_teachers: [] ]
  		params.require(:classroom).permit(accessible)
  	end

  end
end
