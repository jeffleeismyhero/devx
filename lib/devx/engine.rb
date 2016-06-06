module Devx
  class Engine < ::Rails::Engine
    isolate_namespace Devx
    
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    config.to_prepare do
      Devise::SessionsController.layout 'devx/login'
    end

    initializer 'devx.assets.precompile' do |app|
      app.config.assets.precompile += app.config.assets.precompile += %w( devx/devx_portal.css )
      app.config.assets.precompile += app.config.assets.precompile += %w( ckeditor/* )
    end
  end
end
