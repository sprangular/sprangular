class Sprangular.Variant
  init: ->
    @name = if @option_values[0] then @option_values[0].presentation else ""

    @images = _.map @images, (image) ->
      mini: image.mini_url
      small: image.small_url
      large: image.large_url
      extra: image.extra_url

    @image = @images[0]

  isAvailable: ->
    !@track_inventory || @in_stock
