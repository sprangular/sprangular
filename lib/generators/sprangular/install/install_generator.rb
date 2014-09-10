class Sprangular::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def add_routes
    route "mount Sprangular::Engine => '/'"
    route "mount Spree::Core::Engine => '/spree'"
  end

  def add_assets
    append_file 'app/assets/javascripts/application.js', "//= require sprangular"
    inject_into_file 'app/assets/stylesheets/application.css', " *= require sprangular\n", before: /\*\//, verbose: true
  end
end
