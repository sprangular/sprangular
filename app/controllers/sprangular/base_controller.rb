class Sprangular::BaseController < Spree::BaseController
  include Spree::Core::ControllerHelpers::Order
  include Sprangular::Csrf

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  respond_to :json

  layout false

  helper Spree::Api::ApiHelpers

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

  def check_authorization
    @user = current_spree_user

    unauthorized unless @user
  end

  def current_currency
    Spree::Config[:currency]
  end
  helper_method :current_currency

end
