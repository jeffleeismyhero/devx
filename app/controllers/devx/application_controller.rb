module Devx
  class ApplicationController < ActionController::Base
    Date.beginning_of_week = :sunday

    def app_settings
      Devx::ApplicationSetting.find_or_create_by(id: 1).settings
    end

    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end

    def gather_models
      models = ['all']

      # Gather all controllerss from the Portal directory
      controllers = Dir.new("#{Devx::Engine.root}/app/controllers/devx/portal").entries
      controllers.each do |controller|
        if controller =~ /_controller/
          models << controller.gsub('_controller.rb','').singularize.humanize.titleize
        end
      end

      return models
    end
  end
end
