require_dependency "devx/application_controller"

module Devx
  class Portal::DeveloperController < ApplicationController
    before_filter :authenticate_user!
    authorize_resource :application_setting, class: 'Devx::ApplicationSetting'
    layout 'devx/portal'

    def index
      @settings = app_settings
    end

    def update
      if request.post?
        @app = app_settings
        @app.settings = params[:settings]

        if @app.save
          redirect_to devx.portal_developer_index_path,
          notice: "Successfully updated application"
        end
      end
    end

    def commerce_settings
      @settings = app_settings
    end

    def sms_alert_settings
      @settings = app_settings
    end

    private

    def app_settings
      return Devx::ApplicationSetting.find_or_create_by(id: 1)
    end
  end
end
