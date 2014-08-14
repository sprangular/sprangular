class Sprangular::EnvController < Sprangular::BaseController
  def show
    @config = Spree::Config
    @templates = Hash[
      Rails.application.assets.each_logical_path.
      select { |file| file.end_with?('html') }.
      map { |file| [file, ActionController::Base.helpers.asset_path(file)] }
    ]
  end
end
