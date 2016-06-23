module Devx
  class Engine < ::Rails::Engine
    isolate_namespace Devx

    ## Required modules
    require 'acts-as-taggable-on'

    ## Configuration
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.active_job.queue_adapter = :delayed_job
    # Delayed::Web::Job.backend = 'active_record'

    config.to_prepare do
      Devise::SessionsController.layout 'devx/login'
    end

    ## E-mail configuration
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default_url_options = { host: 'devxcms.com' }
    ActionMailer::Base.smtp_settings = {
      user_name: 'jcwproductions1',
      password: 'NolaProductions1284',
      domain: 'devxcms.com',
      address: 'smtp.sendgrid.net',
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true
    }


    ## Initializers

    initializer 'devx.assets.precompile' do |app|
      app.config.assets.precompile += app.config.assets.precompile += %w( devx/devx_portal.css )
      app.config.assets.precompile += app.config.assets.precompile += %w( ckeditor/* )
      app.config.assets.precompile += %w( dj_mon/dj_mon.js dj_mon/dj_mon.css)
      app.config.assets.precompile += app.config.assets.precompile += %w( devx/* )
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
