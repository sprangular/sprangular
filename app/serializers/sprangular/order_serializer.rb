module Sprangular
  class OrderSerializer < BaseSerializer
    attributes :id, :number, :item_total, :total, :ship_total, :state,
               :adjustment_total, :user_id, :created_at, :updated_at,
               :completed_at, :payment_total, :shipment_state, :payment_state,
               :email, :special_instructions, :channel, :included_tax_total,
               :additional_tax_total, :display_included_tax_total,
               :display_additional_tax_total, :tax_total, :currency,
               :display_item_total, :display_total, :display_ship_total,
               :display_tax_total, :checkout_steps

    attribute :total_quantity

    def total_quantity
      object.line_items.sum(:quantity)
    end

    has_one :bill_address, serializer: Sprangular::AddressSerializer
    # has_one :ship_address

    has_many :line_items, serializer: Sprangular::LineItemSerializer

    has_many :payments, serializer: Sprangular::PaymentSerializer

    has_many :shipments, serializer: Sprangular::SmallShipmentSerializer

    has_many :adjustments, serializer: Sprangular::AdjustmentSerializer

    attribute :permissions

    def permissions
      { can_update: current_ability.can?(:update, object) }
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
