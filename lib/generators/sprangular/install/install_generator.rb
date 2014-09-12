class Sprangular::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def add_routes
    route "mount Sprangular::Engine => '/'"
    route "mount Spree::Core::Engine => '/spree'"
  end

  def add_assets
    inject_into_file 'app/assets/stylesheets/application.css', " *= require sprangular\n", before: /\*\//, verbose: true
    append_file 'app/assets/javascripts/application.js', <<-eos
//= require sprangular
//= require sprangular/extraRoutes
eos

    copy_file 'extraRoutes.coffee', 'app/assets/javascripts/sprangular/extraRoutes.coffee'
    copy_file 'about.html.slim', 'app/assets/templates/static/about.html.slim'
    copy_file 'terms.html.slim', 'app/assets/templates/static/terms.html.slim'
    copy_file 'privacy.html.slim', 'app/assets/templates/static/privacy.html.slim'
  end
end
