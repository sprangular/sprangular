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

    self = @
    @options = {}

    _.each @option_types, (type) ->
      self.options[type.id] = {type: type, values: {}}

    _.each @variants, (variant) ->
      variant.product = self

      _.each variant.option_values, (value) ->
        type = _.find(self.option_types, (type) -> type.id == value.option_type_id )
        option = self.options[type.id]

        option.values[value.id] = {value: value, variants: []} unless option.values[value.id]
        option.values[value.id].variants.push(variant)
