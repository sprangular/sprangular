require "active_model_serializers"

module Sprangular
  class BaseSerializer < ActiveModel::Serializer
    extend Spree::Api::ApiHelpers
  end
end
