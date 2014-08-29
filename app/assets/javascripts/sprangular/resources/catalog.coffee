Sprangular.service 'Catalog', ($http, $q, _) ->
  products: (page=1, search=null) ->
    @getPaged('/products', page, search)

  productsByTaxon: (path,page=1) ->
    @getPaged("/products", params: {q: {taxons_permalink_eq: path}})

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

  getPaged: (path, page=1, search=null) ->
    $http.get(path, params: {per_page: 40, page: page, "q[name_or_description_cont]": search})
         .then (response) ->
           list = Sprangular.extend(response.data?.products || [], Sprangular.Product)
           list.isLastPage = list.length < 40
           list
