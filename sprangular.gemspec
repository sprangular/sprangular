$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'sprangular/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'sprangular'
  s.version     = Sprangular::VERSION
  s.authors     = ['Bryan Mahoney', 'Josh Nussbaum']
  s.email       = ['bryan@godynamo.com', 'josh@godynamo.com']
  s.homepage    = 'http://www.godynamo.com'
  s.summary     = 'Spree + Angular.js frontend'
  s.description = 'Spree frontend using angular.js'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails'
  s.add_dependency 'spree_core', '>= 2.4'
  s.add_dependency 'spree_api', '>= 2.4'
  s.add_dependency 'spree_auth_devise'
  s.add_dependency 'slim-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'rack-rewrite'
  s.add_dependency 'ngannotate-rails', '0.15.4'
  s.add_dependency 'prerender_rails'
  s.add_dependency 'active_model_serializers', '~> 0.8.3'
  s.add_dependency 'font-awesome-rails', '~> 4.2'
  s.add_dependency 'rails-assets-angular', '1.3.9'
  s.add_dependency 'rails-assets-angular-route'
  s.add_dependency 'rails-assets-angular-sanitize'
  s.add_dependency 'rails-assets-angular-animate'
  s.add_dependency 'rails-assets-bootstrap-sass-official'
  s.add_dependency 'rails-assets-angular-strap'
  s.add_dependency 'rails-assets-angular-motion'
  s.add_dependency 'rails-assets-bootstrap-additions'
  s.add_dependency 'rails-assets-underscore'
  s.add_dependency 'rails-assets-underscore.string'
  s.add_dependency 'rails-assets-angularytics'
  s.add_dependency 'rails-assets-angular-translate'
  s.add_dependency 'rails-assets-angular-i18n'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'spree_sample'
  s.add_development_dependency 'letter_opener'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-angular'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'chromedriver-helper'
  s.add_development_dependency 'poltergeist'
end
