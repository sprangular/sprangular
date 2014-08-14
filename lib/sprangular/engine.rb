module Sprangular
  class Engine < ::Rails::Engine
    initializer "sprangular.assets.configure" do |app|
      Rails.application.assets.register_mime_type 'text/html', '.html'
      Rails.application.assets.register_engine '.slim', Slim::Template
    end
  end
end
