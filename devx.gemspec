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
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency "rails", ">= 4.2"
  s.add_runtime_dependency "sqlite3"
  s.add_runtime_dependency "jquery-rails"
  s.add_runtime_dependency "sass-rails", "~> 5.0"
  s.add_runtime_dependency "devise"
  s.add_runtime_dependency "cancancan"
  s.add_runtime_dependency "paranoia", "~> 2.0"
  s.add_runtime_dependency "friendly_id"
  s.add_runtime_dependency "ckeditor", "~> 4.1"
  s.add_runtime_dependency "carrierwave"
  s.add_runtime_dependency "mini_magick"
  s.add_runtime_dependency "acts-as-taggable-on"
  s.add_runtime_dependency "twilio-ruby"
  s.add_runtime_dependency "shortcode"
  s.add_runtime_dependency "liquid"
  s.add_runtime_dependency "select2-rails"
  s.add_runtime_dependency "font-awesome-rails"
  s.add_runtime_dependency "twitter"
  s.add_runtime_dependency "koala"
  s.add_runtime_dependency "rails_autolink"
  s.add_runtime_dependency "wow-rails"
  s.add_runtime_dependency "animate-rails"
  s.add_runtime_dependency "breadcrumbs_on_rails"
  s.add_runtime_dependency "stripe"
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  # s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  # s.add_development_dependency "capybara-webkit"
  # s.add_development_dependency "selenium-webdriver"
  # s.add_development_dependency "capybara-screenshot"

end
