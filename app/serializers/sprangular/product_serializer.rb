module Sprangular
  class ProductSerializer < BaseSerializer
    attributes :id, :name, :description, :price, :display_price,
               :available_on, :slug, :meta_title, :meta_description, :meta_keywords,
               :shipping_category_id, :taxon_ids, :has_variants

    has_one :master, serializer: Sprangular::SmallVariantSerializer

    has_many :variants, embed: :objects,
                        serializer: Sprangular::SmallVariantSerializer

    has_many :option_types, serializer: Sprangular::OptionTypeSerializer

    has_many :product_properties, embed: :objects,
                                  serializer: Sprangular::ProductPropertySerializer

    has_many :classifications, embed: :objects,
                               serializer: Sprangular::ClassificationSerializer

    # rubocop:disable Style/PredicateName
    def has_variants
      object.has_variants?
    end
    # rubocop:enable Style/PredicateName
  end
end
