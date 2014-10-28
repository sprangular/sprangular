$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sprangular/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sprangular"
  s.version     = Sprangular::VERSION
  s.authors     = ["Simon Walsh", "Hugo Frappier", "Josh Nussbaum"]
  s.email       = ["simon@walsh.si", "hugo@godynamo.com", "josh@godynamo.com"]
  s.homepage    = "http://www.godynamo.com"
  s.summary     = "Spree + Angular.js frontend"
  s.description = "Spree frontend using angular.js"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.1.4'
  s.add_dependency 'spree_core', '~> 2.3.1'
  s.add_dependency 'spree_api', '~> 2.3.1'
  s.add_dependency 'slim-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'angularjs-rails'
  s.add_dependency 'rack-rewrite'
  s.add_dependency 'bootstrap-sass', '~> 3.1.1'
  s.add_dependency 'geocoder'
  s.add_dependency 'font-awesome-rails', '~> 4.2'
  s.add_dependency 'rails-assets-angular-bootstrap'
  s.add_dependency 'rails-assets-angular-strap'
  s.add_dependency 'rails-assets-angular-motion'
  s.add_dependency 'rails-assets-bootstrap-additions'
  s.add_dependency 'rails-assets-ngInfiniteScroll'
  s.add_dependency 'rails-assets-underscore'
  s.add_dependency 'rails-assets-underscore.string'
  s.add_dependency 'rails-assets-angularytics'
  s.add_dependency 'rails-assets-jasmine-sinon'
  s.add_dependency 'rails-assets-sinon'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "spree_sample"
  s.add_development_dependency "spree_auth_devise"
  s.add_development_dependency "pry"
end
