class Sprangular.User
  init: ->
    @creditCards = []
    @billingAddresses = Sprangular.extend(@shipping_addresses, Sprangular.Address)
    @shippingAddresses = Sprangular.extend(@billing_addresses, Sprangular.Address)
    @_mergeAddressLists()
    @orders = Sprangular.extend(@orders, Sprangular.Order)

    for paymentSource in @payment_sources
      card = new Sprangular.CreditCard
      card.init(paymentSource)

      @creditCards.push(card)

    @allowOneClick = @creditCards.length > 0 && @addresses.length > 0

  serialize: ->
    _.omit this, (value) ->
      typeof(value) == 'object' || typeof(value) == 'function' || Array.isArray(value)

  _mergeAddressLists: ->
    addresses = []
    unique = (address) ->
      addresses[address.key] = address

    _.each @shippingAddresses, unique
    _.each @billingAddresses, unique

    @addresses = _.values(addresses)
