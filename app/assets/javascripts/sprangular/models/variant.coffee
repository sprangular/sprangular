class Sprangular.Variant
  init: ->
    @name = if @option_values[0] then @option_values[0].presentation else ""

    @images = Sprangular.extend(@images, Sprangular.Image)

    @image = @images[0]

  isAvailable: ->
    !@track_inventory || @in_stock || @is_backorderable
