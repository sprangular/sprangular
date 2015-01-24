class Sprangular::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :module_name, type: :string, default: File.basename(Dir.pwd).underscore.camelize
  class_option :copy_templates, type: :boolean, default: false

  def remove_spree_umbrella_gem
    gsub_file 'Gemfile', /^.*gem.["']spree["'].*\n/, ''
  end

  def remove_spree_core_engine_route
    gsub_file 'config/routes.rb', /^.*Spree::Core::Engine.*\n/, ''
  end

  def add_routes
    route "mount Sprangular::Engine  => '/'"
    route "mount Spree::Core::Engine => '/spree'"
  end

  def remove_assets
    git rm: "-rf vendor/assets/images/spree/frontend"
    git rm: "-rf vendor/assets/javascripts/spree/frontend"
    git rm: "-rf vendor/assets/stylesheets/spree/frontend"
  end

  def remove_uneeded_js
    gsub_file 'app/assets/javascripts/application.js', %r{//= require jquery\n}, ''
    gsub_file 'app/assets/javascripts/application.js', %r{//= require jquery_ujs\n}, ''
    gsub_file 'app/assets/javascripts/application.js', %r{//= require turbolinks\n}, ''
    gsub_file 'app/assets/javascripts/application.js', %r{//= require_tree .\n}, ''
  end

  def add_assets
    inject_into_file 'app/assets/stylesheets/application.css', " *= require sprangular\n", before: /\*\//, verbose: true
    append_file 'app/assets/javascripts/application.js', <<-eos
//= require jquery
//= require bootstrap-sass-official
//= require sprangular
//= require sprangular/host
//= require sprangular/extraRoutes
eos

    template 'host.coffee',        'app/assets/javascripts/sprangular/host.coffee'
    template 'extraRoutes.coffee', 'app/assets/javascripts/sprangular/extraRoutes.coffee'

    copy_file 'about.html.slim',    'app/assets/templates/static/about.html.slim'
    copy_file 'terms.html.slim',    'app/assets/templates/static/terms.html.slim'
    copy_file 'privacy.html.slim',  'app/assets/templates/static/privacy.html.slim'
  end

  def add_layout
    template 'layout.slim', 'app/views/layouts/sprangular/application.slim'
  end
end
