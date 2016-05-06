$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devx/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devx"
  s.version     = Devx::VERSION
  s.authors     = ["Rashaad R. Randall"]
  s.email       = ["rashaad@jcwproductions.com"]
  s.homepage    = "https://github.com/jcwproductions/devx"
  s.summary     = "DevX is a comprehensive Content Management System, powered by JCW Productions."
  s.description = "DevX is a comprehensive Content Management System, powered by JCW Productions."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.2"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "pg"
  s.add_dependency "devise"
  s.add_dependency "cancancan"
  s.add_dependency "paranoia", "~> 2.0"
  s.add_dependency "friendly_id"
  s.add_dependency "ckeditor", "~> 4.1"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency "delayed_job"
  s.add_dependency "delayed_job_active_record"
  s.add_dependency "daemons"
  s.add_dependency "twilio-ruby"
  
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "capybara-screenshot"

end
