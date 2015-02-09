module Sprangular::OrderCheckoutDecorator
  def update_from_params(params, permitted_params, request_env = {})
    success = false
    @updating_params = params
    run_callbacks :updating_from_params do
      attributes = @updating_params[:order] ? @updating_params[:order].permit(permitted_params).delete_if { |k,v| v.nil? } : {}

      # Set existing card after setting permitted parameters because
      # rails would slice parameters containg ruby objects, apparently
      existing_card_id = @updating_params[:order] ? @updating_params[:order][:existing_card] : nil

      if existing_card_id.present?
        credit_card = ::Spree::CreditCard.find existing_card_id
        if credit_card.user_id != self.user_id || credit_card.user_id.blank?
          raise ::Spree::Core::GatewayError.new Spree.t(:invalid_credit_card)
        end

        credit_card.verification_value = params[:cvc_confirm] if params[:cvc_confirm].present?

        attributes[:payments_attributes].first[:source] = credit_card
        attributes[:payments_attributes].first[:payment_method_id] = credit_card.payment_method_id
        attributes[:payments_attributes].first.delete :source_attributes
      end

      if attributes[:payments_attributes]
        attributes[:payments_attributes].first[:request_env] = request_env
      end

      if attributes[:payments_attributes] && attributes[:payments_attributes].first[:source_attributes].nil? && existing_card_id.nil?
        # don't allow payments to be created until we're ready to confirm
        attributes.delete :payments_attributes
      end

      # Adds Sprangular support to resuse an address
      if attributes[:bill_address_attributes]
        existing_billing_address = attributes[:bill_address_attributes][:id]

        if existing_billing_address.present?
          bill_address = ::Spree::Address.find(existing_billing_address)
          self.bill_address = bill_address
          attributes.delete :bill_address_attributes
        end

        existing_shipping_address = attributes[:ship_address_attributes][:id]

        if existing_shipping_address.present?
          ship_address = ::Spree::Address.find(existing_shipping_address)
          self.ship_address = ship_address
          attributes.delete :ship_address_attributes
        end
      end

      success = self.update_attributes(attributes)
      set_shipments_cost if self.shipments.any?
    end

    @updating_params = nil
    success
  end

  # override the default method here to prevent invalid payments from being created
  def assign_default_credit_card
    true
  end
end

Spree::Order.send :prepend, Sprangular::OrderCheckoutDecorator
