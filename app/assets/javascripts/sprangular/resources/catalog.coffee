Sprangular.service 'Catalog', ($http, $q, _) ->
  products: (search=null, page=1) ->
    @getPaged(page, search: search)

  productsByTaxon: (path, page=1) ->
    @getPaged(page, taxon: path)

  taxonomies: ->
    $http.get("/taxonomies")
      .then (response) ->
        response.data

  taxon: (path) ->
    $http.get("/taxons/#{path}")
      .then (response) ->
        response.data

  find: (id) ->
    $http.get("/products/#{id}", class: Sprangular.Product)

  getPaged: (page=1, params={}) ->
    $http.get("/products", params: {per_page: 40, page: page, "q[name_or_description_cont]": params.search, "q[taxons_permalink_eq]": params.taxon})
         .then (response) ->
           list = Sprangular.extend(response.data?.products || [], Sprangular.Product)
           list.isLastPage = list.length < 40
           list
