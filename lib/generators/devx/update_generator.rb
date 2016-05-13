module Devx
  class InstallGenerator < Rails::Generators::Base
    def install
      rake 'devx:install:migrations'
    end
  end
end