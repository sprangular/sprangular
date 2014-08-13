$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sprangular/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sprangular"
  s.version     = Sprangular::VERSION
  s.authors     = ["Simon Walsh", "Hugo", "Braden", "Josh Nussbaum"]
  s.email       = ["simon@walsh.si", "hugo@godynamo.com", "braden@godynamo.com", "josh@godynamo.com"]
  s.homepage    = "http://www.godynamo.com"
  s.summary     = "Spree + Angular.js frontend"
  s.description = "Spree frontend using angular.js"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.4"
  s.add_dependency "spree_core"
  s.add_dependency "spree_api"
  s.add_dependency "slim"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
