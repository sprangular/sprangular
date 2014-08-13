module Sprangular
  class Engine < ::Rails::Engine
    isolate_namespace Sprangular

    initializer "sprangular.assets.configure" do |app|
      app.assets.register_mime_type 'text/html', '.html'
      app.assets.register_engine '.slim', Slim::Template
    end
  end
end
