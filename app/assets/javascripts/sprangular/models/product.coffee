class Sprangular.Product
  init: ->
    images = @master.images

    @permalink = "#!/products/#{@slug}"

    @image = {
      mini: images[0].mini_url
      small: images[0].small_url
      large: images[0].large_url
      extra: images[0].extra_url
    }

    if @variants.length > 0
      @hasVariants = true
      @variants = Sprangular.extend(@variants, Sprangular.Variant)
    else
      @hasVariants = false
      @master = Sprangular.extend(@master, Sprangular.Variant)
      @variants = [@master]

    _.each @variants, (variant) -> variant.product = this
