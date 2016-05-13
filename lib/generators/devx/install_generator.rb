module Devx
  class InstallGenerator < Rails::Generators::Base
    def install
      run 'bundle install'
      route %Q{mount Devx::Engine => '/'}
      rake 'devx:install:migrations'
    end
  end
end