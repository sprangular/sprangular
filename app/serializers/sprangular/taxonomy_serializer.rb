module Sprangular
  class TaxonomySerializer < BaseSerializer
    attributes *taxonomy_attributes

    has_one :root, embed: :objects,
                   serializer: Sprangular::TaxonSerializer
  end
end
