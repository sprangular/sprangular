'use strict'

Sprangular.config ($provide, $httpProvider, Env) ->

  $provide.factory 'railsAssetsInterceptor', ->
    request: (config) ->
      url = config.url.replace(/^[\/]?assets\//, '')

      if assetUrl = Env.templates[url]
        config.url = assetUrl
      else if url.match(/.html$/)
        config.url = "/assets/#{url}"

      config

  $httpProvider.interceptors.push('railsAssetsInterceptor')
