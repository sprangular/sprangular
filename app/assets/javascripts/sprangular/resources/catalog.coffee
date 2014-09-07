Sprangular.service 'Catalog', ($http, $q, _) ->
  service =
    pageSize: 8

    products: (search=null, page=1) ->
      @getPaged(page, search: search)

    productsByTaxon: (path, page=1) ->
      @getPaged(page, taxon: path)

    taxonomies: ->
      $http.get("/api/taxonomies")
        .then (response) ->
          response.data

    taxon: (path) ->
      $http.get("/api/taxons/#{path}")
        .then (response) ->
          response.data

    find: (id) ->
      $http.get("/api/products/#{id}", class: Sprangular.Product)

    getPaged: (page=1, params={}) ->
      $http.get("/api/products", params: {per_page: @pageSize, page: page, "q[name_or_description_cont]": params.search, "q[taxons_permalink_eq]": params.taxon})
           .then (response) ->
             data = response.data
             list = Sprangular.extend(data.products || [], Sprangular.Product)
             list.isLastPage = (data.count < service.pageSize) || (page == data.pages)
             list.totalCount = data.total_count
             list.totalPages = data.pages
             list.page = data.current_page
             list

  service
