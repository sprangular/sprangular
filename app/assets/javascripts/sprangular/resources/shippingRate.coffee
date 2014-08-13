Sprangular.factory "ShippingRate", ($q, $http, _) ->

  class Sprangular.ShippingRate

    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes = {}) ->
      angular.extend this, attributes

    serialize: ->
      name: @name
      cost: @cost
      shipping_method_id: @shippingMethodId
      display_cost: @displayCost

    this.load = (shippingRate = {}) ->
      new Sprangular.ShippingRate
        id: shippingRate.id
        name: shippingRate.name
        cost: shippingRate.cost
        shippingMethodId: shippingRate.shipping_method_id
        displayCost: shippingRate.display_cost



