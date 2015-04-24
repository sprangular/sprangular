module Sprangular
  class UserSerializer < BaseSerializer
    attributes *(user_attributes | [:bill_address_id, :ship_address_id])

    has_many :addresses,        serializer: Sprangular::AddressSerializer
    has_many :payment_sources,  serializer: Sprangular::PaymentSourceSerializer
    has_one  :bill_address,     serializer: Sprangular::AddressSerializer
    has_one  :ship_address,     serializer: Sprangular::AddressSerializer

    def payment_sources
      object.credit_cards
    end
  end
end
