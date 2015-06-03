class Sprangular.Variant
  init: ->
    @images = Sprangular.extend(@images, Sprangular.Image)

    @image = @images[0]

  isAvailable: ->
    !@track_inventory || @in_stock || @is_backorderable
