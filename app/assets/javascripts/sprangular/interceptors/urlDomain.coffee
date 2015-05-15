'use strict'

Sprangular.config ($provide, $httpProvider) ->

  $provide.factory 'apiDomainInterceptor', ($q, Status, Env) ->
    request: (config) ->
      if config.useApiDomain is undefined or config.useApiDomain
        config.url = (Env.api_domain + config.url)
      config

  $httpProvider.interceptors.push('apiDomainInterceptor')
