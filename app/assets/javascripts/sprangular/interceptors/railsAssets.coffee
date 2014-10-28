'use strict'

Sprangular.config ($provide, $httpProvider, Env) ->

  $provide.factory 'railsAssetsInterceptor', ->
    request: (config) ->
      url = config.url.gsub(/^\/assets\//, '')

      if assetUrl = Env.templates[url]
        config.url = assetUrl

      config

  $httpProvider.interceptors.push('railsAssetsInterceptor')
