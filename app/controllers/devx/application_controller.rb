module Devx
  class ApplicationController < ActionController::Base

    def app_settings
      Devx::ApplicationSetting.find_or_create_by(id: 1).settings
    end
    
    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end
  end
end
