require_dependency "devx/application_controller"

module Devx
  class Portal::SlideshowsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :slideshow, class: 'Devx::Slideshow'
    layout 'devx/portal'

    def index
    end

    def edit
    end

    def new
    end

    def create
      if @slideshow.valid? && @slideshow.save
        redirect_to devx.portal_slideshows_path,
        notice: "Successfully saved slideshow"
      else
        render :new,
        notice: "Failed to save slideshow"
      end
    end

    def update
      if @slideshow.valid? && @slideshow.update(slideshow_params)
        redirect_to devx.edit_portal_slideshow_path(@slideshow),
        notice: "Successfully updated slideshow"
      else
        render :edit,
        notice: "Failed to update slideshow"
      end
    end

    def destroy
      if @slideshow.destroy
        redirect_to devx.portal_slideshows_path,
        notice: "Successfully deleted slideshow"
      else
        redirect_to devx.portal_slideshows_path,
        notice: "Failed to delete slideshow"
      end
    end

    def sort
      list = params[:slide]
      list.try(:each_with_index) do |id, index|
        Devx::Slide.find(id).update_columns(position: index + 1)
      end
      render json: nil, status: :ok
    rescue
    end


    private

    def slideshow_params
      accessible = [ :name,
                    slides_attributes: [ :id, :slideshow_id, :title, :content, :image, :link, :active, :_destroy ]
                  ]
      params.require(:slideshow).permit(accessible)
    end
  end
end
