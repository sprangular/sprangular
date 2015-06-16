Sprangular.service 'Catalog', ($http, $q, _, Status, Env) ->
  service =
    pageSize: Env.config.product_page_size

    products: (keywords=null, page=1, options) ->
      options ||= {}
      options.keywords = keywords
      @getPaged(page, options)

    productsByTaxon: (taxonId, page=1) ->
      @getPaged(page, taxon: taxonId)

    taxonomies: ->
      $http.get("/api/taxonomies", cache: true)
        .then (response) ->
          response.data.taxonomies

    taxonsByName: (name) ->
      @taxonomies().then (response)->
        result = null
        if name
          _.each response, (taxon)->
            if taxon.name is name
              result = taxon.root.taxons
        else
          result = response.data
        return result

    taxon: (path) ->
      $http.get("/api/taxons/#{path}")
        .then (response) ->
          response.data.taxon

    find: (id) ->
      $http.get("/api/products/#{id}", class: Sprangular.Product)
        .then (response) ->
          Status.cacheProduct(response)
          response

    getPaged: (page=1, params={}) ->
      queryParams =
        per_page:     params.pageSize || @pageSize
        page:         page
        keywords:     params.keywords
        taxon:        params.taxon
        taxons:       params.taxons
        option_types: params.optionTypes
        price_min:    params.price?.min
        price_max:    params.price?.max
        sorting:      params.sorting

      for key, value of queryParams
        delete queryParams[key] unless value

      $http.get("/api/products?#{$.param(queryParams)}", ignoreLoadingIndicator: params.ignoreLoadingIndicator)
        .then (response) ->
          data = response.data
          list = Sprangular.extend(data.products || [], Sprangular.Product)
          list.isLastPage = (data.meta.count < service.pageSize) || (page == data.pages)
          list.totalCount = data.meta.total_count
          list.totalPages = data.meta.pages
          list.page = data.meta.current_page
          list

  service
