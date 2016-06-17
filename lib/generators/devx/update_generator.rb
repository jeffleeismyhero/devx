module Devx
  class UpdateGenerator < Rails::Generators::Base
    def update
      run 'bundle install'
      rake 'devx:install:migrations'
    end
  end
end