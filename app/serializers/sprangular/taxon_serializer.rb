module Sprangular
  class TaxonSerializer < BaseSerializer
    attributes :id, :name, :pretty_name, :permalink, :parent_id, :taxonomy_id

    has_many :children, key: :taxons, serializer: self
  end
end
