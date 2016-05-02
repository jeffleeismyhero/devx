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
  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "sass-rails", "~> 5.0"
  s.add_development_dependency "pg"
  s.add_development_dependency "devise"
  s.add_development_dependency "cancancan"
  s.add_development_dependency "paranoia", "~> 2.0"
  s.add_development_dependency "friendly_id"
  s.add_development_dependency "ckeditor"
  s.add_development_dependency "carrierwave"
  s.add_development_dependency "mini_magick"
  
end
