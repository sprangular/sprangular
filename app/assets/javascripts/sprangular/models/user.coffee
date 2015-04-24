class Sprangular.User
  init: ->
    @creditCards     = Sprangular.extend(@payment_sources || [], Sprangular.CreditCard)
    @addresses       = Sprangular.extend(@addresses || [], Sprangular.Address)
    @billingAddress  = Sprangular.extend(@bill_address, Sprangular.Address) if @bill_address
    @shippingAddress = Sprangular.extend(@ship_address, Sprangular.Address) if @ship_address

  serialize: ->
    _.omit this, (value) ->
      typeof(value) == 'object' || typeof(value) == 'function' || Array.isArray(value)

  findAddress: (id) ->
    _.find @addresses, (address) -> address.id == id
