module Devx
  class InstallGenerator < Rails::Generators::Base
    def install
      run 'bundle install'
      route "mount Devx::Engine => '/'"
      rake 'devx:install:migrations'
      rake 'db:migrate'
    end
  end
end