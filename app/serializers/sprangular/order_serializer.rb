module Sprangular
  class OrderSerializer < BaseSerializer
    attributes *order_attributes
    attributes | [:display_total, :display_item_total, :display_ship_total, :display_tax_total, :checkout_steps]

    attribute :total_quantity
    attribute :token

    def total_quantity
      object.line_items.sum(:quantity)
    end

    def token
      object.guest_token
    end

    has_one :bill_address, serializer: Sprangular::AddressSerializer
    has_one :ship_address, serializer: Sprangular::AddressSerializer

    has_many :line_items, serializer: Sprangular::LineItemSerializer

    has_many :payments, serializer: Sprangular::PaymentSerializer

    has_many :shipments, serializer: Sprangular::SmallShipmentSerializer

    has_many :adjustments, serializer: Sprangular::AdjustmentSerializer

    has_many :products, serializer: Sprangular::ProductSerializer

    has_many :line_item_adjustments, serializer: Sprangular::AdjustmentSerializer

    attribute :permissions

    def permissions
      { can_update: current_ability.can?(:update, object) }
    end

    attribute :use_billing

    def use_billing
      object.bill_address == object.ship_address
    end

    # TODO Handle order state-based attributes
    # def attributes
    #   super.tap do |attrs|
    #     # case object.
    #   end
    # end

    private

    def current_ability
      Spree::Ability.new(scope)
    end
  end
end
