# lib/tasks/prmissions/generate.rake

namespace :permissions do
  desc 'Generates all permissions by available models'
  task generate: :environment do
    models = []

    # Gather all controllerss from the Portal directory
    controllers = Dir.new("#{Devx::Engine.root}/app/controllers/devx/portal").entries
    controllers.each do |controller|
      if controller =~ /_controller/
        models << controller.gsub('_controller.rb','').singularize.camelize
      end
    end

    # Define DevX model
    models.each do |model|
      begin
        if m = "Devx::#{model}".constantize
          actions = ['read', 'list', 'create', 'update', 'manage']
          actions.each do |action|
            puts Devx::Permission.create(object_class: model, action: action).inspect
          end
        end
      rescue NameError
      end
    end

  end
end
