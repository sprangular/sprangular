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
      config = ::Spree::Config
      store = Spree::Store.current
      templates = Hash[
        Rails.application.assets.each_logical_path.
        select { |file| file.end_with?('html') }.
        map do |file|
          path = digest_assets? ? File.join('/assets', Rails.application.assets[file].digest_path) : asset_path(file)

          [file, path]
        end
      ]

      {env: Rails.env,
        config: {
          site_name: store.seo_title || store.name,
          logo:      asset_path(config.logo),
          locale:    I18n.locale,
          default_country_id: config.default_country_id,
          payment_methods: payment_methods,
          image_sizes: Spree::Image.attachment_definitions[:attachment][:styles].keys,
          product_page_size: Spree::Config.products_per_page
        },
        translations: current_translations[:sprangular].to_json.html_safe,
        templates: templates
      }
    end

    def current_translations
      @translations ||= I18n.backend.send(:translations)
      @translations[I18n.locale].with_indifferent_access
    end

    def cached_templates
      Sprangular::Engine.config.cached_paths.inject({}) do |files, dir|
        cached_templates_for_dir(files, dir)
      end
    end

    def cached_templates_for_dir(files, dir)
      root = Sprangular::Engine.root

      files = Dir[root + "app/assets/templates/#{dir}/**"].inject(files) do |hash, path|
        asset_path = asset_path path.gsub(root.to_s + "/app/assets/templates/", "")
        local_path = "app/assets/templates/#{I18n.locale}/" + asset_path
        

        hash[asset_path.gsub(/.slim$/, '')] = Tilt.new(path).render.html_safe if !File.exists?(local_path)

        hash
      end

      Dir["app/assets/templates/#{dir}/**"].inject(files) do |hash, path|
        sprockets_path = path.gsub("app/assets/templates/", "")
        
        asset_path = asset_path(sprockets_path).
          gsub(/^\/app\/assets\/templates/, "/assets/").
          gsub(/.slim$/, '')

        hash[asset_path] = Rails.application.assets.find_asset(sprockets_path).body.html_safe
        hash
      end
    end
  end
end
