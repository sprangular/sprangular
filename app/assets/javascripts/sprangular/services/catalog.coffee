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
      $http.get("/api/taxonomies", {cache: true})
        .then (response) ->
          response.data

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
      $http.get("/api/taxons/#{path}", {cache: true})
        .then (response) ->
          response.data

    find: (id) ->
      $http.get("/api/products/#{id}", class: Sprangular.Product, {cache: true})

    getPaged: (page=1, params={}) ->
      $http.get("/api/products", ignoreLoadingIndicator: params.ignoreLoadingIndicator, params: {per_page: @pageSize, page: page, "q[name_or_description_cont]": params.search, "q[taxons_permalink_eq]": params.taxon}, {cache: true})
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
