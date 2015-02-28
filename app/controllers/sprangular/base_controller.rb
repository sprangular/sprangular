class Sprangular::BaseController < Spree::BaseController
  include Spree::Core::ControllerHelpers::Order
  include Sprangular::Csrf

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  respond_to :json

  layout false

  helper Spree::Api::ApiHelpers

  before_action :load_user_roles

  before_action :set_language

  def invalid_resource!(resource)
    @resource = resource
    render "sprangular/errors/invalid", status: 422
  end

  def unauthorized
    render "sprangular/errors/unauthorized", status: 401
  end

  def not_found
    render "sprangular/errors/not_found", status: 404
  end

protected
  def set_language
    I18n.locale = if session.key?(:locale)
                    session[:locale]
                  else
                    Rails.application.config.i18n.default_locale || I18n.default_locale
                  end
  end


  def check_authorization
    @user = current_spree_user

    unauthorized unless @user
  end

  def current_currency
    Spree::Config[:currency]
  end
  helper_method :current_currency

  def load_user_roles
    @current_user_roles = if @current_spree_user
      @current_spree_user.spree_roles.pluck(:name)
    else
      []
    end
  end
end
