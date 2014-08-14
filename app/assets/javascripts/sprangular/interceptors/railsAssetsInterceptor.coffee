'use strict'

Sprangular.config ($provide, $httpProvider, Env) ->

  $provide.factory 'railsAssetsInterceptor', ->
    request: (config) ->
      if assetUrl = Env.templates[config.url]
        config.url = assetUrl

      config

  $httpProvider.interceptors.push('railsAssetsInterceptor')
