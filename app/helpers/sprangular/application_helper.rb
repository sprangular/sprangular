module Sprangular
  module ApplicationHelper
    def payment_methods
      hash = {}
      methods = (Spree::PaymentMethod.available(:front_end) + Spree::PaymentMethod.available(:both)).uniq
      methods.map do |method|
        hash[method.method_type] = {
          id: method.id,
          name: method.name,
          publishable_key: method.preferences[:publishable_key]
        }
      end
      hash
    end

    def js_environment
      config = Spree::Config
      templates = Hash[
        Rails.application.assets.each_logical_path.
        select { |file| file.end_with?('html') }.
        map { |file| [file, ActionController::Base.helpers.asset_path(file)] }
      ]

      {env: Rails.env,
        config: {
          site_name: config.site_name,
          logo:      asset_path(config.logo),
          default_country_id: config.default_country_id,
          facebook_app_id: ENV['FACEBOOK_APP_ID']
        },
        templates: templates
      }
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
        local_path = 'app/assets/templates/' + asset_path

        hash[asset_path] = Tilt.new(path).render.html_safe if !File.exists?(local_path)

        hash
      end

      Dir["app/assets/templates/#{dir}/**"].inject(files) do |hash, path|
        asset_path = asset_path path.gsub("/app/assets/templates/", "")

        hash[asset_path] = Tilt.new(path).render.html_safe
        hash
      end
    end
  end
end
