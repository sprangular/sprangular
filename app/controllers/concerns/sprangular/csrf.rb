module Sprangular::Csrf
  extend ActiveSupport::Concern

  included do
    protect_from_forgery

    after_filter :set_csrf_cookie
  end

protected

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
