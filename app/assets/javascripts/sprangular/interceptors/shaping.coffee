Sprangular.config ($provide, $httpProvider) ->

  $provide.factory 'shapingInterceptor', ->
    response: (response) ->
      cls = response.config.class

      if cls
        Sprangular.extend(response.data, cls)
      else
        response

  $httpProvider.interceptors.push('shapingInterceptor')
