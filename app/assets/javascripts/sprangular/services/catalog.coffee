Sprangular.service 'Catalog', ($http, $q, _, Status, Env) ->
  service =
    pageSize: Env.config.product_page_size

    products: (search=null, page=1, options) ->
      options ||= {}
      options.search = search
      @getPaged(page, options)

    productsByTaxon: (path, page=1) ->
      @getPaged(page, taxon: path)

    taxonomies: (name)->
      $http.get("/api/taxonomies", {cache: true})
        .then (response) ->
          if name
            $log.debug "taxonomies - if name", response
            _.each response, (taxon)->
              if taxon.name is name
                return taxon.root.taxons
          else
            response.data            

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
