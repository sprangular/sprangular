module Sprangular
  class CountrySerializer < BaseSerializer
    attributes(*country_attributes)

    has_many :states, serializer: Sprangular::StateSerializer
  end
end
