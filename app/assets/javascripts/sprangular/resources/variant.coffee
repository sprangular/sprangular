Sprangular.factory 'Variant', (_) ->

  class Sprangular.Variant

    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes = {}) ->
      angular.extend this, attributes

    setProduct: (product) ->
      @product = product

    this.load = (data = {}) ->
      # console.log data
      name = if data.option_values[0] then data.option_values[0].presentation else ""
      cssColor = if data.option_values[0] then data.option_values[0].css_color else ""
      new Sprangular.Variant
        id: data.id
        name: name
        css_color: '#' + cssColor
        slug: data.slug
        image_url: data.images[0].small_url
        price: data.price
        in_stock: data.in_stock
