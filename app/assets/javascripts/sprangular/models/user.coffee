class Sprangular.User
  init: ->
    @addresses       = Sprangular.extend(@addresses || [], Sprangular.Address)
    @billingAddress  = @findAddress(@bill_address_id) if @bill_address_id
    @shippingAddress = @findAddress(@ship_address_id) if @ship_address_id

    @orders      = Sprangular.extend(@completed_orders, Sprangular.Order)
    @creditCards = Sprangular.extend(@payment_sources, Sprangular.CreditCard)

  serialize: ->
    _.omit this, (value) ->
      typeof(value) == 'object' || typeof(value) == 'function' || Array.isArray(value)

  _extendAddress: (attrs) ->
    Sprangular.extend(attrs, Sprangular.Address)
