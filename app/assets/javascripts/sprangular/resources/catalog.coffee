Sprangular.service 'Catalog', ($http, $q, _) ->

  service =
    products: (page=1) ->
      @getPaged('/products', page)

    taxon: (path,page=1) ->
      @getPaged("/products/?category=#{path}", page)

    find: (id) ->
      @get("/products/#{id}")

    get: (path) ->
      $http.get(path, class: Sprangular.Product)

    getPaged: (path, page=1) ->
      $http.get(path, params: {per_page: 40, page: page})
           .then (response) ->
             list = Sprangular.extend(response.data?.products || [], Sprangular.Product)
             list.isLastPage = list.length < 40
             list

  service
