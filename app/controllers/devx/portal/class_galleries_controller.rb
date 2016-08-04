require_dependency "devx/application_controller"

module Devx
  class Portal::ClassGalleriesController < ApplicationController
  	before_filter :authenticate_user!
  	load_and_authorize_resource :class_gallery, class: 'Devx::ClassGallery'
    load_and_authorize_resource :classroom, class: 'Devx::Classroom'

  	layout 'devx/portal'

  	def index
      @class_galleries = Devx::ClassGallery.where(classroom: @classroom)
  	end

  	def new
  	end

  	def create

      @class_gallery.classroom = @classroom

  		if @class_gallery.valid? && @class_gallery.save
  			redirect_to devx.portal_classroom_class_galleries_path,
  			notice: "Class gallery has been successfully created."
  		else
  			render :new,
  			notice: "Class gallery failed to create."
  		end
  	end

  	def edit
  	end

  	def update
  		if @class_gallery.valid? && @class_gallery.update
  			redirect_to devx.portal_class_gallery_path(class_gallery_params),
  			notice: "Class gallery has been successfully updated."
  		else
  			render :edit,
  			notice: "Class gallery failed to update."
  		end
  	end

  	def show
  	end

  	def destroy
  		if @class_gallery.destroy
  			redirect_to devx.portal_classroom_class_galleries_path,
  			notice: "Class gallery was successfully deleted."
  		else
  			redirect_to devx.portal_classroom_class_galleries_path,
  			notice: "Class gallery failed to delete."
  		end
  	end

  	private

  	def class_gallery_params
  		accessible = [:name, :active]
  		params.require(:class_gallery).permit(accessible)
  	end

  end
end
