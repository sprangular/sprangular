'use strict'

class Sprangular.Order
  constructor: ->
    @clear()

  init: ->

  clear: ->
    @number = ''
    @items = []
    @billingAddress = new Sprangular.Address
    @shippingAddress = new Sprangular.Address
    @creditCard = new Sprangular.CreditCard
    @shipToBillAddress = true
    @subTotal = 0
    @taxTotal = 0
    @shippingTotal = 0
    @total = 0

  isEmpty: ->
    @items.length == 0

  totalQuantity: ->
    @items.reduce ((total, item) -> total + item.quantity), 0

  findVariant: (variantId) ->
    item for item in @items when item.variant.id is variantId

  hasVariant: (variant) ->
    variant && @findVariant(variant.id).length > 0
