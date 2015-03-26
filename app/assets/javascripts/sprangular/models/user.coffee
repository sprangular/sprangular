class Sprangular.User
  init: ->
    @billingAddresses  = @_extendAddress(@shipping_addresses)
    @shippingAddresses = @_extendAddress(@billing_addresses)
    @billingAddress    = @_extendAddress(@billing_address)
    @shippingAddress   = @_extendAddress(@shipping_address)

    @orders      = Sprangular.extend(@orders, Sprangular.Order)
    @creditCards = Sprangular.extend(@payment_sources, Sprangular.CreditCard)

    @_mergeAddressLists()

    @allowOneClick = @creditCards.length > 0 && @addresses.length > 0

  serialize: ->
    _.omit this, (value) ->
      typeof(value) == 'object' || typeof(value) == 'function' || Array.isArray(value)

  _extendAddress: (attrs) ->
    Sprangular.extend(attrs, Sprangular.Address)

  _mergeAddressLists: ->
    addresses = []
    unique = (address) ->
      addresses[address.key] = address

    _.each @shippingAddresses, unique
    _.each @billingAddresses, unique

    @addresses = _.values(addresses)
