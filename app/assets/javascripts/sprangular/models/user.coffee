class Sprangular.User
  init: ->
    @addresses       = @_extendAddress(@addresses)
    @billingAddress  = @_extendAddress(@billing_address)
    @shippingAddress = @_extendAddress(@shipping_address)

    @orders      = Sprangular.extend(@completed_orders, Sprangular.Order)
    @creditCards = Sprangular.extend(@payment_sources, Sprangular.CreditCard)

  serialize: ->
    _.omit this, (value) ->
      typeof(value) == 'object' || typeof(value) == 'function' || Array.isArray(value)

  _extendAddress: (attrs) ->
    Sprangular.extend(attrs, Sprangular.Address)
