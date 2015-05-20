Sprangular.service 'Catalog', ($http, $q, _, Status, Env) ->
  service =
    pageSize: Env.config.product_page_size

    products: (search=null, page=1, options) ->
      options ||= {}
      options.search = search
      @getPaged(page, options)

    productsByTaxon: (path, page=1, options) ->
      options ||= {}
      @getPaged(page, taxon: path, options)

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

    getPaged: (page=1, params={}, options) ->
      ignoreLoading = if options then options.ignoreLoadingIndicator else false
      $http.get("/api/products", ignoreLoadingIndicator: ignoreLoading, params: {per_page: @pageSize, page: page, "q[name_or_description_cont]": params.search, "q[taxons_permalink_eq]": params.taxon})
        .then (response) ->
          data = response.data
          list = Sprangular.extend(data.products || [], Sprangular.Product)
          list.isLastPage = (data.meta.count < service.pageSize) || (page == data.pages)
          list.totalCount = data.meta.total_count
          list.totalPages = data.meta.pages
          list.page = data.meta.current_page
          list

  service
