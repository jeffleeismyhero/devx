module Devx
  class InstallGenerator < Rails::Generators::Base
    def install
      run 'bundle install'
      route %Q{mount Devx::Engine => '/'}
      rake 'db:create'
      rake 'db:migrate'
    end
  end
end