module Sprangular
  class AddressSerializer < BaseSerializer
    attributes *address_attributes

    has_one :country, serializer: Sprangular::CountrySerializer
    has_one :state, serializer: Sprangular::StateSerializer
  end
end
