'use strict'

Sprangular.config ($provide, $httpProvider) ->

  $provide.factory 'loadingInterceptor', ($q, Status) ->
    request: (config) ->
      Status.loading = true

      config

    response: (response) ->
      Status.loading = false

      response

    responseError: (rejection) ->
      Status.loading = false

      $q.reject(rejection)

  $httpProvider.interceptors.push('loadingInterceptor')
