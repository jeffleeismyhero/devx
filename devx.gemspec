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

  
  ## Base Gems
  s.add_runtime_dependency "rails", ">= 4.2"
  s.add_runtime_dependency "sqlite3"
  s.add_runtime_dependency "jquery-rails"
  s.add_runtime_dependency "coffee-rails", "~> 4.1.0"
  s.add_runtime_dependency "sass-rails", "~> 5.0"


  ## Authentication
  s.add_runtime_dependency "devise"
  s.add_runtime_dependency "cancancan"
  s.add_runtime_dependency "omniauth"
  s.add_runtime_dependency "omniauth-google-oauth2"


  ## Data Management
  s.add_runtime_dependency "paranoia", "~> 2.0"
  s.add_runtime_dependency "friendly_id"
  s.add_runtime_dependency "ransack"
  s.add_runtime_dependency "acts-as-taggable-on"
  s.add_runtime_dependency "will_paginate"


  ## User Interface
  s.add_runtime_dependency "select2-rails"
  s.add_runtime_dependency "font-awesome-rails"
  s.add_runtime_dependency "wow-rails"
  s.add_runtime_dependency "animate-rails"


  ## WYSIWYG Editor
  s.add_runtime_dependency "ckeditor", "~> 4.1"  


  ## Image Processing
  s.add_runtime_dependency "carrierwave"
  s.add_runtime_dependency "mini_magick"
  s.add_runtime_dependency "dropzonejs-rails"


  ## Payment solutions
  s.add_runtime_dependency "stripe"
  s.add_runtime_dependency "payeezy", "~> 1.1"
  

  ## Data Import/Export
  s.add_runtime_dependency "axlsx"
  s.add_runtime_dependency "axlsx_rails"


  ## Conversion Tracking
  s.add_runtime_dependency "mixpanel-ruby"


  ## Social Networks
  s.add_runtime_dependency "twitter"
  s.add_runtime_dependency "koala"


  ## Google Calendar Integration
  s.add_runtime_dependency "google_calendar"
  s.add_runtime_dependency "icalendar"


  ## CMS Functionality
  s.add_runtime_dependency "liquid"
  s.add_runtime_dependency "shortcode"
  s.add_runtime_dependency "breadcrumbs_on_rails"


  ## SMS Integration
  s.add_runtime_dependency "twilio-ruby"


  ## Miscellaneous
  s.add_runtime_dependency "rails_autolink"



  ## Development Gems

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  # s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  # s.add_development_dependency "capybara-webkit"
  # s.add_development_dependency "selenium-webdriver"
  # s.add_development_dependency "capybara-screenshot"

end
