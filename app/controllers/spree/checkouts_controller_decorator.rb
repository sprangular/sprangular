module Spree
  module CheckoutsControllerExtensions
    def self.prepended(base)
      base.after_filter :reset_guest_token, only: :update
    end

    def reset_guest_token
      return unless @order.complete?
      cookies.delete :guest_token
    end
  end
end

Spree::Api::CheckoutsController.prepend Spree::CheckoutsControllerExtensions
