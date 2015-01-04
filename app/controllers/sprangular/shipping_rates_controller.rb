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

    @order = current_order
    @order.use_billing = params[:use_billing]

    if @order.use_billing
      update_address(@order.bill_address ||= Spree::Address.new, country_id, state_id, zipcode)
    else
      update_address(@order.ship_address ||= Spree::Address.new, country_id, state_id, zipcode)
    end

    render 'spree/api/orders/show'
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
    address.zipcode = zipcode if zipcode
    address.save!
  end
end
