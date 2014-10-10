class Sprangular::ShippingRatesController < Sprangular::BaseController
  def index
    country_id = params[:country_id]
    state_id = params[:state_id]

    if current_order.use_billing
      update_address(current_order.bill_address ||= Spree::Address.new, country_id, state_id)
    else
      update_address(current_order.ship_address ||= Spree::Address.new, country_id, state_id)
    end

    @shipping_rates = shipping_rates
  end

private
  def update_address(address, country_id, state_id)
    current_order.ship_address.country_id = country_id
    current_order.ship_address.state_id = state_id
  end

  def shipping_rates
    packages = Spree::Stock::Coordinator.new(current_order).packages

    grouped = packages.map(&:shipping_rates).flatten.inject({}) do |memo, rate|
      memo[rate.shipping_method_id] ||= Spree::ShippingRate.new(shipping_method: rate.shipping_method, cost: 0)
      memo[rate.shipping_method_id].cost += rate.cost
      memo
    end

    grouped.values
  end
end
