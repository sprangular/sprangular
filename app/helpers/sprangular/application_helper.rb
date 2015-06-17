module Sprangular
  module ApplicationHelper
    def payment_methods
      Spree::PaymentMethod.available(:front_end).map do |method|
        {
          id: method.id,
          name: method.name
        }
      end
    end

    def js_environment
      {
        env: Rails.env,
        config: js_config,
        locale: I18n.locale,
        currency: Money::Currency.table[current_currency.downcase.to_sym],
        translations: current_translations,
        templates: template_paths
      }
    end

    def js_config
      Rails.cache.fetch('js_config') do
        config = ::Spree::Config
        store = Spree::Store.current

        {
          site_name: store.seo_title || store.name,
          logo: asset_path(config.logo),
          supported_locales: supported_locales,
          default_country_id: config.default_country_id,
          payment_methods: payment_methods,
          image_sizes:
            Spree::Image.attachment_definitions[:attachment][:styles].keys,
          product_page_size: Spree::Config.products_per_page
        }
      end
    end

    def template_paths
      Rails.cache.fetch('template_paths') do
        logical_paths = assets_environment.each_logical_path("*.html")

        Hash[logical_paths.map { |file| [file, asset_path(file)] }]
      end
    end

    def supported_locales
      if defined? SpreeI18n
        SpreeI18n::Config.supported_locales
      else
        Rails.application.config.i18n.available_locales
      end
    end

    ##
    # Get relevant translations for front end. For both a simple, and
    # "Chainable" i18n Backend, which is used by spree i18n.
    def current_translations
      Rails.cache.fetch("current_translations.#{I18n.locale}") do
        if I18n.backend.class == I18n::Backend::Simple
          I18n.backend.load_translations

          @translations ||= I18n.backend.send(:translations)
        else
          @translations ||= I18n.backend.backends.last.send(:translations)
        end
        # Return only sprangular keys for js environment
        @translations[I18n.locale][:sprangular]
      end
    end

    def cached_templates
      Sprangular::Engine.config.cached_paths.inject({}) do |files, dir|
        cached_templates_for_dir(files, dir)
      end
    end

    def cached_templates_for_dir(files, dir)
      logical_paths = templates_environment.each_logical_path("#{dir}/**")

      logical_paths.inject(files) do |hash, path|
        hash[asset_path(path)] = assets_environment[path].body.html_safe
        hash
      end
    end

    def serialize(object, serializer)
      serializer.new(object, root: false).to_json
    end

    private

    def templates_environment
      @_templates_environment ||= Sprockets::Environment.new.tap do |env|
        [Rails.root, Sprangular::Engine.root].each do |root|
          env.append_path root.join("app/assets/templates/")
        end
      end
    end
  end
end
