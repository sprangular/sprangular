'use strict'

Sprangular.config ($provide, $httpProvider) ->

  $provide.factory 'loadingInterceptor', ($q, Status) ->
    request: (config) ->
      Status.httpLoading = true

      config

    response: (response) ->
      Status.httpLoading = false

      response

    responseError: (rejection) ->
      Status.httpLoading = false

      $q.reject(rejection)

  $httpProvider.interceptors.push('loadingInterceptor')
