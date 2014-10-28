Sprangular.service 'Shipment', (ShippingRate) ->

  Shipment =

    id: null
    rates: []
    loaded: false

    # Load shipping rates from order shipment
    load: (shipment) ->
      @id = shipment.id
      @rates.length = 0
      for shippingRate in shipment.shipping_rates
        @rates.push ShippingRate.load(shippingRate)
      @loaded = true

    findRate: (shippingRateId) ->
      for shippingRate in @rates
        return shippingRate if shippingRate.id is shippingRateId