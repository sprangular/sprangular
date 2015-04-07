module Sprangular
  class AdjustmentSerializer < BaseSerializer
    attributes :id, :source_type, :source_id, :adjustable_type, :adjustable_id,
               :amount, :label, :mandatory,
               :included, :eligible, :display_amount
  end
end
