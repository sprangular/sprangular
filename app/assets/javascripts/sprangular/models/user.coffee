class Sprangular.User
  init: ->
    @creditCards     = Sprangular.extend(@payment_sources || [], Sprangular.CreditCard)
    @addresses       = Sprangular.extend(@addresses || [], Sprangular.Address)
    @billingAddress  = @findAddress(@bill_address_id) if @bill_address_id
    @shippingAddress = @findAddress(@ship_address_id) if @ship_address_id

  serialize: ->
    _.omit this, (value) ->
      typeof(value) == 'object' || typeof(value) == 'function' || Array.isArray(value)

  findAddress: (id) ->
    _.find @addresses, (address) -> address.id == id
