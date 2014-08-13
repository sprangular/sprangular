Sprangular.factory 'Product', (_, Variant) ->

  class Sprangular.Product

    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes = {}) ->
      angular.extend this, attributes

    this.load = (data = {}) ->
      product = new Sprangular.Product
        id: data.master.id
        name: data.name
        slug: data.slug
        binding: "products/content/#{data.slug}.html"
        permalink: "#!/products/#{data.slug}"
        image_mini: data.master.images[0].mini_url
        image_small: data.master.images[0].small_url
        image_large: data.master.images[0].large_url
        image_extra: data.master.images[0].extra_url
        description: data.description
        body:
          how_to_use: data.body_how_to_use
          ingredients: data.body_ingredients
          benefits: data.body_benefits

      if data.variants.length > 0
        product.hasVariants = true
        product.variants = (Variant.load(variant) for variant in data.variants)
      else
        product.hasVariants = false
        product.variants = [Variant.load(data.master)]

      variant.setProduct(product) for variant in product.variants

      return product

