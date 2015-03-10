module Sprangular
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)
    config.paths['app/views'] << File.join(Gem.loaded_specs['spree_auth_devise'].full_gem_path, "lib/views/frontend")
    config.cached_paths = %w(layout directives products home cart promos)

    initializer "sprangular.assets.configure" do
      assets = Rails.application.assets

      assets.register_mime_type 'text/html', '.html'
      assets.register_engine '.slim', Slim::Template

      Rails.application.config.assets.precompile += %w( bootstrap/* )
    end

    initializer "sprangular.locales" do
      config  = Rails.application.config

      locales = if defined? SpreeI18n
                  SpreeI18n::Config.supported_locales
                else
                  config.i18n.available_locales
                end

      if locales
        config.assets.precompile += locales.map do |locale|
          "angular-i18n/angular-locale_#{locale}*"
        end
      end
    end

    initializer "sprangular.prerender" do
      Rails.application.config.middleware.use Rack::Prerender, prerender_token: ENV['PRERENDER_TOKEN']
    end

    initializer "sprangular.add_middleware" do |app|
      app.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
        r301 '/products',          '/#!/products'
        r301 %r{^/products/(.+)$}, '/#!/products/$1'
        r301 %r{^/t/(.+)$},        '/#!/t/$1'
        r301 '/sign_in',           '/#!/sign-in'
        r301 '/cart',              '/#!/cart'
        r301 '/account',           '/#!/account'
        r301 '/spree/login',       '/#!/sign-in?redirect=y'
        r301 '/admin',             '/spree/admin'
        r301 %r{/spree/user/spree_user/password/edit\?reset_password_token=(.+)}, '/#!/reset-password/$1'
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
