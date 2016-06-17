module Devx
  class UpdateGenerator < Rails::Generators::Base
    def update
      run 'bundle update devx | grep devx'
      rake 'db:migrate'
    end
  end
end