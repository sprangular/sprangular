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
          logo:      config.logo,
          facebook_app_id: ENV['FACEBOOK_APP_ID']
        },
        templates: templates
      }
    end
  end
end
