module Sprangular
  class LineItemSerializer < BaseSerializer
    attributes *line_item_attributes
    attributes :single_display_amount, :display_amount, :total

    has_many :adjustments, serializer: Sprangular::AdjustmentSerializer
    has_one :variant, serializer: Sprangular::SmallVariantSerializer
  end
end
