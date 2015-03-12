module Sprangular
  class OptionValueSerializer < BaseSerializer
    attributes :id, :name, :presentation, :option_type_name, :option_type_id,
               :option_type_presentation
  end
end
