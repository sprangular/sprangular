class Sprangular::ShippingRatesController < Sprangular::BaseController
  def index
    country_id = params[:country_id]
    state_id = params[:state_id]

    @shipping_rates = shipping_rates
  end

private

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
