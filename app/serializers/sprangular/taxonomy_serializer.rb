module Sprangular
  class TaxonomySerializer < BaseSerializer
    attributes :id, :name

    has_one :root, embed: :objects,
                   serializer: Sprangular::TaxonSerializer
  end
end
