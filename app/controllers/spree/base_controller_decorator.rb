# TODO: should be just Spree::BaseController once base class is fixed here:
# https://github.com/DynamoMTL/spree_chimpy/blob/master/app/controllers/spree/chimpy/subscribers_controller.rb#L1
[ApplicationController, Spree::BaseController].each do |klass|
  klass.class_eval do
    after_filter :set_csrf_cookie_for_ng

  protected

    def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end

    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end
  end
end
