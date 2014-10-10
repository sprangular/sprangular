'use strict'

class Sprangular.Order
  constructor: ->
    @creditCard = new Sprangular.CreditCard

    @clear()

  init: ->

  clear: ->
    @number = ''
    @items = []
    @billingAddress = new Sprangular.Address
    @shippingAddress = new Sprangular.Address
    @shipToBillAddress = true
    @itemTotal = 0
    @taxTotal = 0
    @shipTotal = 0
    @total = 0
    @errors = null

  isEmpty: ->
    @items.length == 0

  isValid: ->
    @billingAddress.validate()
    @actualShippingAddress().validate()
    @creditCard.validate()

    @billingAddress.isValid() && @actualShippingAddress().isValid() && (@creditCard.id || @creditCard.isValid())

  isInvalid: ->
    !@isValid()

  totalQuantity: ->
    @items.reduce ((total, item) -> total + item.quantity), 0

  findVariant: (variantId) ->
    item for item in @items when item.variant.id is variantId

  hasVariant: (variant) ->
    variant && @findVariant(variant.id).length > 0

  updateTotals: ->
    @total = @itemTotal + @taxTotal + @shipTotal

  actualShippingAddress: ->
    if @shipToBillAddress
      @billingAddress
    else
      @shippingAddress
