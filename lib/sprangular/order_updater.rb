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
      goto = @params[:goto]

      if goto == 'complete'
        advance_until(&:complete?)
      else
        if addresses_changed?
          Rails.logger.info "Reverting to address and advance to delivery"
          revert_to(:address) && advance_until(&:delivery?)
        end

        if addresses_changed? || shipping_rate_changed?
          Rails.logger.info "Reverting to delivery and update order"
          revert_to(:delivery) && update_order
        end

        if goto == 'payment'
          Rails.logger.info "Advancing to payment"
          advance_until(&:payment?)
        end
      end
    end

    def revert_to(state)
      @order.update(state: state) unless @order.state == state
    end

    def advance_until
      update_order
      advance until yield(@order)
    end

    def advance
      if @order.delivery? && @selected_rate
        shipment = @order.shipments.first
        available_rate = shipment.shipping_rates.detect {|rate| rate.shipping_method_id == @selected_rate.shipping_method_id && rate.cost == @selected_rate.cost}
        shipment.update(selected_shipping_rate_id: available_rate.id) if available_rate
      end
      @order.next!
    end

    def addresses_changed?
      order_attrs = @params[:order]

      new_bill_attrs = order_attrs[:bill_address_attributes]
      new_ship_attrs = order_attrs[:ship_address_attributes]

      new_ship_attrs = new_bill_attrs if order_attrs[:use_billing] == 'true'

      old_bill_attrs = address_attrs(@order.bill_address)
      old_ship_attrs = address_attrs(@order.ship_address)

      old_bill_attrs != new_bill_attrs || old_ship_attrs != new_ship_attrs
    end

    def address_attrs(address)
      return {} unless address

      {firstname:  address.firstname,
       lastname:   address.lastname,
       address1:   address.address1,
       address2:   address.address2,
       city:       address.city,
       state_id:   address.state_id.to_s,
       country_id: address.country_id.to_s,
       zipcode:    address.zipcode,
       phone:      address.phone}.stringify_keys
    end

    def shipping_rate_changed?
      new_shipping_method_id = @selected_rate.try(:shipping_method_id)
      old_shipping_method_id = @order.shipments.try(:first).try(:shipping_method).try(:id)

      new_shipping_method_id != old_shipping_method_id
    end

    def update_order
      @order.update_from_params(@params, permitted_checkout_attributes, @request.headers.env)
    end

    def find_selected_rate(order)
      return unless attrs = @params[:order][:shipments_attributes].try(:first)

      return unless shipment = order.shipments.detect {|shipment| shipment.id == attrs[:id].to_i}
      shipment.shipping_rates.find(attrs[:selected_shipping_rate_id])
    end
  end
end
