'use strict'

class Sprangular.Order
  constructor: ->
    @number = ''
    @lines = []
    @billingAddress = new Sprangular.Address
    @shippingAddress = new Sprangular.Address
    @creditCard = new Sprangular.CreditCard
    @shipToBillAddress = true

  init: ->
