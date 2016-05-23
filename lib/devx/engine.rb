module Devx
  class Engine < ::Rails::Engine
    isolate_namespace Devx

    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    config.generators do |g|
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'devx.assets.precompile' do |app|
      app.config.assets.precompile += app.config.assets.precompile += %w( ckeditor/* )
    end
  end
end
