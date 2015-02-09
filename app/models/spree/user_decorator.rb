module UserExtensions
  def past_bill_addresses
    past_addresses :bill_address
  end

  def past_ship_addresses
    past_addresses :ship_address
  end

  def completed_orders
    orders.complete.order('updated_at DESC')
  end

  private

  def past_addresses(address_type)
    addresses = (past_orders_with_most_recent_first(address_type).map(&address_type) + [send(address_type)]).compact
    addresses.uniq do |a|
      [a.lastname.to_s, a.firstname.to_s, a.address1.to_s, a.address2.to_s, a.city.to_s, a.zipcode.to_s, a.phone.to_s,
        a.state_id.to_s, a.state_name.to_s, a.country_id.to_s]
    end
  end

  def past_orders_with_most_recent_first(address_type)
    completed_orders.includes(address_type => [:state, :country])
  end
end

Spree.user_class.send(:prepend, UserExtensions)
