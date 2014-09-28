'use strict'

class Sprangular.Order
  constructor: ->
    @number = ''
    @lines = []
    @billingAddress = new Sprangular.Address
    @shippingAddress = new Sprangular.Address
    @creditCard = new Sprangular.CreditCard
    @shipToBillAddress = true
    @subTotal = 0
    @taxTotal = 0
    @shippingTotal = 0
    @total = 0

  init: ->
