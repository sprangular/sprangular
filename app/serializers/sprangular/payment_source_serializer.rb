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

    def month
      object.respond_to?(:month) ? object.month : ""
    end

    def year
      object.respond_to?(:year) ? object.year : ""
    end

    def cc_type
      object.respond_to?(:cc_type) ? object.cc_type : ""
    end

    def last_digits
      object.respond_to?(:last_digits) ? object.last_digits : ""
    end

    def name
      object.respond_to?(:name) ? object.name : ""
    end

    def gateway_payment_profile_id
      object.respond_to?(:gateway_payment_profile_id) ? object.gateway_payment_profile_id : ""
    end

    def gateway_customer_profile_id
      object.respond_to?(:gateway_customer_profile_id) ? object.gateway_customer_profile_id : ""
    end

  end
end
