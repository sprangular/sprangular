module Sprangular
  class AdjustmentSerializer < BaseSerializer
    attributes :id, :source_type, :source_id, :adjustable_type, :adjustable_id,
<<<<<<< HEAD
               :originator_type, :originator_id, :amount, :label, :mandatory,
               :locked, :eligible, :created_at, :updated_at, :display_amount
=======
               :amount, :label, :mandatory,
               :included, :eligible, :display_amount
>>>>>>> master
  end
end
