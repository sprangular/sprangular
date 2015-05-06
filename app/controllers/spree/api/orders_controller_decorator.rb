module Spree
  module Api
    module OrdersControllerExtensions

      def apply_coupon_code
        find_order
        authorize! :update, @order, order_token
        @order.coupon_code = params[:coupon_code]
        @handler = PromotionHandler::Coupon.new(@order).apply
        status = @handler.successful? ? 200 : 422
        render json: @order,
               scope: current_spree_user,
               serializer: Sprangular::OrderSerializer,
               root: :order,
               status: status,
               meta: {
                 success: @handler.success,
                 error: @handler.error,
                 successful: @handler.successful?,
                 status_code: @handler.status_code
               }
      end

    end
  end
end

Spree::Api::OrdersController.prepend Spree::Api::OrdersControllerExtensions
