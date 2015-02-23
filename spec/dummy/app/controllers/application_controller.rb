class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user_language

  def set_user_language
    I18n.locale = if session.key?(:locale)
      session[:locale]
    else
      Rails.application.config.i18n.default_locale || I18n.default_locale
    end
  end
end
