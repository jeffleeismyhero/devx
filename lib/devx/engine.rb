module Devx
  class Engine < ::Rails::Engine
    isolate_namespace Devx

    require 'acts-as-taggable-on'
    
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    config.to_prepare do
      Devise::SessionsController.layout 'devx/login'
    end

    initializer 'devx.assets.precompile' do |app|
      app.config.assets.precompile += app.config.assets.precompile += %w( devx/devx_portal.css )
      app.config.assets.precompile += app.config.assets.precompile += %w( ckeditor/* )
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
