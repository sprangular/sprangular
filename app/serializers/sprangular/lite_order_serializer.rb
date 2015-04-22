module Sprangular
  class LiteOrderSerializer < BaseSerializer
    attributes :number, :payment_state, :completed_at, :state, :total, :shipment_state
  end
end
