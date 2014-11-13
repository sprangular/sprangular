class Sprangular.Variant
  init: ->
    @name = if @option_values[0] then @option_values[0].presentation else ""

    @images = _.map @images, (image) ->
      miniUrl: image.mini_url
      smallUrl: image.small_url
      largeUrl: image.large_url
      productUrl: image.product_url

    @image = @images[0]

  isAvailable: ->
    !@track_inventory || @in_stock
