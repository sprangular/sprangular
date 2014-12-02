'use strict'

class Sprangular.Order
  constructor: ->
    @creditCard = new Sprangular.CreditCard

    @clear()

  clear: ->
    @number = ''
    @items = []
    @billingAddress = new Sprangular.Address
    @shippingAddress = new Sprangular.Address
    @shipToBillAddress = true
    @itemTotal = 0
    @taxTotal = 0
    @shipTotal = 0
    @adjustmentTotal = 0
    @total = 0
    @errors = null
    @state = null
    @shipmentState = null

  load: (data) ->
    @clear()
    @number = data.number
    @state = data.state
    @shipmentState = data.shipment_state
    @itemTotal = Number(data.item_total)
    @taxTotal = Number(data.tax_total)
    @shipTotal = Number(data.ship_total)
    @adjustmentTotal = Number(data.adjustment_total)
    @total = Number(data.total)
    @shipToBillAddress = data.use_billing
    @adjustments = Sprangular.extend(data.adjustments, Sprangular.Adjustment)

    if data.bill_address
      @billingAddress = Sprangular.extend(data.bill_address, Sprangular.Address)

    if data.ship_address
      @shippingAddress = Sprangular.extend(data.ship_address, Sprangular.Address)

    products = Sprangular.extend(data.products, Sprangular.Product)

    for item in data.line_items
      for product in products
        variant = product.findVariant(item.variant_id)
        break if variant

      @items.push(variant: variant, quantity: item.quantity, price: item.price)

    @

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
    @total = @itemTotal + @adjustmentTotal + @taxTotal + @shipTotal

  actualShippingAddress: ->
    if @shipToBillAddress
      @billingAddress
    else
      @shippingAddress

  resetCreditCard: ->
    @creditCard = new Sprangular.CreditCard
