module Sprangular
  class PaymentSourceSerializer < BaseSerializer
    attributes :id, :month, :year, :cc_type, :last_digits, :name,
               :gateway_customer_profile_id, :gateway_payment_profile_id

    def include_gateway_payment_profile_id?
      scope.has_spree_role?("admin")
    end

    def include_gateway_customer_profile_id?
      scope.has_spree_role?("admin")
    end
  end
end
