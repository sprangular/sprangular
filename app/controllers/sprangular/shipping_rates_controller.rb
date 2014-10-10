class Sprangular::ShippingRatesController < Sprangular::BaseController
  def index
    if params[:zipcode]
      country_id, state_id = lookup_location(params[:zipcode])
      zipcode = params[:zipcode]
    else
      country_id = params[:country_id] || Spree::Config.default_country_id
      state_id = params[:state_id]
      zipcode = ''
    end

    if current_order.use_billing
      update_address(current_order.bill_address ||= Spree::Address.new, country_id, state_id, zipcode)
    else
      update_address(current_order.ship_address ||= Spree::Address.new, country_id, state_id, zipcode)
    end

    @shipping_rates = shipping_rates
  end

private
  def lookup_location(zip)
    country_id, state_id = nil, nil
    results = Geocoder.search(zip)

    if results.present?
      result = results.first
      country_id = Spree::Country.where(iso: result.country_code).first!.id
      state_id = Spree::State.where(abbr: result.state_code).first!.id
    end

    return country_id, state_id
  end

  def update_address(address, country_id, state_id, zipcode)
    address.country_id = country_id
    address.state_id = state_id
    address.zipcode = zipcode
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
