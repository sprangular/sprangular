Sprangular.service 'Catalog', ($http, $q, _) ->
  products: (page=1) ->
    @getPaged('/products', page)

  taxon: (path,page=1) ->
    @getPaged("/products/?category=#{path}", page)

  taxons: ->
    $http.get("/taxons/#{id}")
      .then (response) ->
        response.data

  find: (id) ->
    $http.get("/products/#{id}", class: Sprangular.Product)

  getPaged: (path, page=1) ->
    $http.get(path, params: {per_page: 40, page: page})
         .then (response) ->
           list = Sprangular.extend(response.data?.products || [], Sprangular.Product)
           list.isLastPage = list.length < 40
           list
