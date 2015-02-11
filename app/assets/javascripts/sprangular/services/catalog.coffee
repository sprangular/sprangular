Sprangular.service 'Catalog', ($http, $q, _, Status, Env) ->
  service =
    pageSize: Env.config.product_page_size

    products: (search=null, page=1, options) ->
      options ||= {}
      options.search = search
      @getPaged(page, options)

    productsByTaxon: (path, page=1) ->
      @getPaged(page, taxon: path)

    taxonomies: ->
      $http.get("/api/taxonomies")
        .then (response) ->
          response.data

    taxonsByName: (name) ->
      $http.get("spree/api/taxonomies?q[name_eq]=#{name}")
        .then (response) ->
          response.data.taxonomies[0].root.taxons

    taxon: (path) ->
      $http.get("/api/taxons/#{path}")
        .then (response) ->
          response.data

    find: (id) ->
      $http.get("/api/products/#{id}", class: Sprangular.Product)

    getPaged: (page=1, params={}) ->
      $http.get("/api/products", ignoreLoadingIndicator: params.ignoreLoadingIndicator, params: {per_page: @pageSize, page: page, "q[name_or_description_cont]": params.search, "q[taxons_permalink_eq]": params.taxon})
           .then (response) ->
             data = response.data
             list = Sprangular.extend(data.products || [], Sprangular.Product)
             list.isLastPage = (data.count < service.pageSize) || (page == data.pages)
             list.totalCount = data.total_count
             list.totalPages = data.pages
             list.page = data.current_page
             Status.cacheProducts(list)
             list

  service
