require_dependency "devx/application_controller"

module Devx
  class Portal::ClassAnnouncementsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :class_announcement, class: 'Devx::ClassAnnouncement'
    load_and_authorize_resource :classroom, class: 'Devx::Classroom'
    layout 'devx/portal'

    def index
    end

    def new
    end

    def edit
    end

    def create
      @class_announcement.classroom = @classroom

      if @class_announcement.valid? && @class_announcement.save
        redirect_to devx.edit_portal_classroom_class_announcement_path(@classroom, @class_announcement),
        notice: "Successfully saved announcement"
      else
        render :new,
        notice: "Failed to save announcement"
      end
    end

    def update
      if @class_announcement.valid? && @class_announcement.update(class_announcement_params)
        redirect_to devx.edit_portal_classroom_class_announcement_path(@classroom, @class_announcement),
        notice: "Successfully updated announcement"
      else
        render :new,
        notice: "Failed to update announcement"
      end
    end

    def destroy
      if @class_announcement.destroy
        redirect_to devx.portal_classroom_class_announcements_path,
        notice: "Successfully deleted announcment"
      else
        redirect_to devx.portal_classroom_class_announcements_path,
        notice: "Failed to delete announcement"
      end
    end


    private

    def class_announcement_params
      accessible = [ :content ]
      params.require(:class_announcement).permit(accessible)
    end
  end
end
