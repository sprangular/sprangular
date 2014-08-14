module Sprangular
  module ApplicationHelper
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
