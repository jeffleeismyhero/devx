module Devx
  class Engine < ::Rails::Engine
    isolate_namespace Devx

    require "acts-as-taggable-on"


    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    initializer 'devx.assets.precompile' do |app|
      app.config.assets.precompile += app.config.assets.precompile += %w( ckeditor/* )
    end
  end
end
