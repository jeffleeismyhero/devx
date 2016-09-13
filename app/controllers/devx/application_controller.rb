module Devx
  class ApplicationController < ActionController::Base
    Date.beginning_of_week = :sunday
    impersonates :user,
    method: :current_user,
    with: -> (id) { Devx::User.find(id) }

    def app_settings
      Devx::ApplicationSetting.find_or_create_by(id: 1).settings
    end

    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end
  end
end
