require_dependency "devx/application_controller"

module Devx
  class Portal::ClassPhotosController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :class_photo, class: 'Devx::ClassPhoto'
    load_and_authorize_resource :class_gallery, class: 'Devx::ClassGallery'
    load_and_authorize_resource :classroom, class: 'Devx::Classroom'

    def create
      @class_photo.class_gallery = @class_gallery

      if @class_photo.valid? && @class_photo.save
        redirect_to devx.portal_classroom_class_gallery_path(@classroom, @class_gallery),
        notice: "Successfully uploaded photo"
      else
        redirect_to devx.portal_classroom_class_gallery_path(@classroom, @class_gallery),
        notice: "Failed to upload photo"
      end
    end

    def destroy
      if @class_photo.destroy
        redirect_to devx.portal_classroom_class_gallery_path(@classroom, @class_gallery),
        notice: "Successfully deleted photo"
      else
        redirect_to devx.portal_classroom_class_gallery_path(@classroom, @class_gallery),
        notice: "Failed to delete photo"
      end
    end


    private

    def class_photo_params
      accessible = [ :name, :caption, :filename ]
      params.require(:class_photo).permit(accessible)
    end
  end
end
