Sprangular.service 'Catalog', ($http, $q, _, Product) ->

  fetchDefer = $q.defer()

  service =
    products: []
    variants: []

    init: ->
      catalog = this
      $http.get '/store/products.json'
        .success (data) ->
          catalog.products = (catalog._populateSingle(product) for product in data.products)
          catalog.variants = []
          for product in service.products
            catalog.variants = catalog.variants.concat product.variants
          fetchDefer.resolve catalog
        .error (data) ->
          fetchDefer.resolve service

    fetch: ->
      return fetchDefer.promise

    # query = {id: ...} or {slug: ...}
    findProduct: (query) ->
      _.where(@products, query)[0]

    findVariant: (query) ->
      _.where(@variants, query)[0]

    _populateSingle: (data) ->
      Product.load data

    # query = {id: ...} or {slug: ...}
    findSibling: (delta, query) ->
      currentEl = @findProduct(query)
      currentPos = _.indexOf(@products, currentEl)
      productsLgt = @products.length - 1
      deltaPos = currentPos + delta
      siblingPos = switch
        when deltaPos > productsLgt then 0
        when deltaPos < 0 then productsLgt
        else deltaPos
      url = @products[siblingPos]

  service.init()
  service
