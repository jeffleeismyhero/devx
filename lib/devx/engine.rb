module Devx
  class Engine < ::Rails::Engine
    isolate_namespace Devx

    ## Required modules
    require 'acts-as-taggable-on'

    ## Configuration
    config.assets.paths << "#{Devx::Engine.root}/app/assets/documents"
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.active_job.queue_adapter = :delayed_job

    if ENV["RAILS_ENV"] == "production"
      config.assets.css_compressor = :yui
      config.assets.js_compressor = :yui
    end

    config.to_prepare do
      Devise::SessionsController.layout 'devx/login'
      Devise::RegistrationsController.layout 'devx/sign_up'
      Devise::PasswordsController.layout 'devx/forgot_password'
    end


    ## Initializers

    initializer 'devx.assets.precompile' do |app|
      app.config.assets.precompile += app.config.assets.precompile += %w( devx/devx_portal.css )
      app.config.assets.precompile += app.config.assets.precompile += %w( ckeditor/* )
      app.config.assets.precompile += %w( dj_mon/dj_mon.js dj_mon/dj_mon.css)
      app.config.assets.precompile += app.config.assets.precompile += %w( devx/* )
      app.config.assets.precompile += app.config.assets.precompile += %w( documents/* )
    end

    initializer 'devx_session_store' do |app|
      app.config.session_store :cookie_store, key: '_devx_session', domain: :all
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

  end
end
