require_dependency "devx/application_controller"

module Devx
  class Portal::AnnouncementsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :announcement, class: 'Devx::Announcement'

    layout 'devx/portal'

    def index
    end

    def new
    end

    def create
        if @announcement.valid? && @announcement.save
            redirect_to devx.portal_announcement_path(@announcement),
            notice: "Announcement has been successfully created."
        else 
            render :new,
            notice: "Announcement failed to create."
        end
    end

    def edit
    end

    def update
        if @announcement.valid? && @announcement.update(announcement_params)
            render :edit,
            notice: "Announcement has been successfully updated."
        else
            render :edit,
            notice: "Announcement failed to update."
        end
    end

    def show
    end

    def destroy
        if @announcement.destroy
            redirect_to devx.portal_announcements_path,
            notice: "Announcement has been successfully deleted."
        else
            redirect_to devx.portal_announcements_path,
            notice: "Announcements failed to delete."
        end
    end

    private

    def announcement_params
        accessible = [ :title, :content ]
        params.require(:announcement).permit(accessible)
    end

  end
end
