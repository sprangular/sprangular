module Sprangular
  class TaxonSerializer < BaseSerializer
    attributes *taxon_attributes

    has_many :children, key: :taxons, serializer: self
  end
end
