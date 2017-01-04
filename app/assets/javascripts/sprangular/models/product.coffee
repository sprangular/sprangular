class Sprangular.Product
  init: ->
    @images = Sprangular.extend(@master.images, Sprangular.Image)

    @permalink = "#!/products/#{@slug}"

    if @variants.length > 0
      @hasVariants = true
      @variants = Sprangular.extend(@variants, Sprangular.Variant)
    else
      @hasVariants = false
      @master = Sprangular.extend(@master, Sprangular.Variant)
      @variants = [@master]

    if (@ad_hoc_option_types?.length > 0 || @customization_types?.length > 0)
      @hasFlexi = true

    @image = @variants[0].images[0]

    if !@image?
      @image = @images[0]

    self = @
    @options = {}

    _.each @option_types, (type) ->
      self.options[type.id] = angular.extend(type, values: {})

    _.each @variants, (variant) ->
      variant.product = self

      _.each variant.option_values, (value) ->
        type = _.find(self.option_types, (type) -> type.id == value.option_type_id )
        if type
          option = self.options[type.id]

          option.values[value.position] = {value: value, variants: []} unless option.values[value.position]
          option.values[value.position].variants.push(variant)

  variantForValues: (selectedValues) ->
    _.find @variants, (variant) ->
      variant.option_values.length == selectedValues.length && _.all selectedValues, (selected) ->
        _.find variant.option_values, (value) -> value.id == selected.id

  availableValues: (selectedValues) ->
    self = @

    if selectedValues.length == 0
      _.map self.options, (option) -> option.values
    else
      matchingVariants = _.filter self.variants, (variant) ->
        _.all selectedValues, (selected) ->
          _.find variant.option_values, (value) -> value.id == selected.id

      values = _.map matchingVariants, (variant) -> variant.option_values
      values = _.flatten(values)
      _.unique(values)

  findVariant: (variant_id) ->
    _.find @variants, (variant) -> variant.id == variant_id

  isAvailable: ->
    if @hasVariants
      _.any @variants, (variant) -> variant.isAvailable()
    else
      @master.isAvailable()

  firstAvailableVariant: ->
    if @variants.length == 1
      @variants[0]
    else
      _.find @variants, (variant) -> variant.isAvailable()
