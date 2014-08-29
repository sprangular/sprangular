module Sprangular
  class Engine < ::Rails::Engine
    initializer "sprangular.assets.configure" do |app|
      Rails.application.assets.register_mime_type 'text/html', '.html'
      Rails.application.assets.register_engine '.slim', Slim::Template
    end

    initializer "sprangular.add_middleware" do |app|
      app.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
        r301 '/products',  '/#!/products'
      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    config.to_prepare &method(:activate).to_proc

  end
end
