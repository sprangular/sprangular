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
    @billToShipAddress = true
    @itemTotal = 0
    @taxTotal = 0
    @shipTotal = 0
    @adjustmentTotal = 0
    @total = 0
    @state = null
    @shipmentState = null
    @shippingRates = []
    @shippingRate = null
    @token = null
    @loading = false

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
    @token = data.token
    @billToShipAddress = data.use_billing
    @adjustments = Sprangular.extend(data.adjustments, Sprangular.Adjustment)
    @shippingRates = []
    @completedAt = data.completed_at
    @shipmentState = data.shipment_state
    @shipments = data.shipments
    @payments = data.payments
    @creditApplied = data.total_applicable_store_credit
    @totalAfterCredit = data.order_total_after_store_credit


    @loadRates(data)

    if data.bill_address
      @billingAddress = Sprangular.extend(data.bill_address, Sprangular.Address)

    if data.ship_address
      @shippingAddress = Sprangular.extend(data.ship_address, Sprangular.Address)

    products = Sprangular.extend(data.products, Sprangular.Product)

    for item in data.line_items
      for product in products
        variant = product.findVariant(item.variant_id)
        break if variant

      @items.push(variant: variant, flexi_variant_message: item.flexi_variant_message, quantity: item.quantity, price: item.price)

    @

  loadRates: (data) ->
    @shipment = _.last(data.shipments)

    if @shipment
      @shippingRates = Sprangular.extend(@shipment.shipping_rates, Sprangular.ShippingRate)
      @shippingRate = _.find @shippingRates, (rate) -> rate.selected
    else
      @shippingRate = null

  isEmpty: ->
    @items.length == 0

  isValid: ->
    @shippingAddress.validate()
    @actualBillingAddress().validate()
    @creditCard.validate()

    @actualBillingAddress().isValid() && @shippingAddress.isValid() && (@creditCard.id || @creditCard.isValid())

  isInvalid: ->
    !@isValid()

  totalQuantity: ->
    @items.reduce ((total, item) -> total + item.quantity), 0

  findVariant: (variantId) ->
    item for item in @items when item.variant.id == variantId

  findVariantForProduct: (product) ->
    variants = (item.variant for item in @items when item.variant.product.id == product.id)
    variants[0] if variants

  hasVariant: (variant) ->
    variant && @findVariant(variant.id).length > 0

  updateTotals: ->
    @total = @itemTotal + @adjustmentTotal + @taxTotal + @shipTotal

  actualBillingAddress: ->
    if @billToShipAddress
      @shippingAddress
    else
      @billingAddress

  resetAddresses: (user) ->
    return unless user && user.addresses.length > 0

    @shippingAddress = user.shippingAddress if @shippingAddress.isEmpty()
    @billingAddress  = user.billingAddress  if @billingAddress.isEmpty()

  resetCreditCard: (user) ->
    if user && user.creditCards.length > 0
      @creditCard = _.last(user.creditCards)
    else
      @creditCard = new Sprangular.CreditCard
