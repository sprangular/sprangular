module Sprangular
  class OrderUpdater
    include Spree::Core::ControllerHelpers::StrongParameters

    def self.update(order, request, params)
      new(order, request, params)
    end

    def initialize(order, request, params)
      @order   = order
      @request = request
      @params  = params

      run
    end

  private

    def run
      @selected_rate = find_selected_rate(@order)

      if @params[:complete]
        advance_until(&:complete?)
      else
        revert_to_cart

        advance_until(&:payment?)
      end
    end

    def revert_to_cart
      @order.update(state: 'cart') unless @order.cart?
    end

    def advance_until
      update_order
      advance until yield(@order)
    end

    def advance
      if @order.delivery? && @selected_rate
        shipment = @order.shipments.first
        available_rate = shipment.shipping_rates.detect {|rate| rate.shipping_method_id == @selected_rate.shipping_method_id && rate.cost == @selected_rate.cost}
        shipment.update(selected_shipping_rate_id: available_rate.id)
      end
      @order.next!
    end

    def update_order
      @order.update_from_params(@params, permitted_checkout_attributes, @request.headers.env)
    end

    def find_selected_rate(order)
      return unless attrs = @params[:order][:shipments_attributes].try(:first)

      shipment = order.shipments.detect {|shipment| shipment.id == attrs[:id].to_i}
      shipment.shipping_rates.find(attrs[:selected_shipping_rate_id])
    end
  end
end
