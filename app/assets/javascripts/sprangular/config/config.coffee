Sprangular.config [
  '$httpProvider'
  '$locationProvider'
  '$translateProvider'
  '$logProvider'
  'Env'
  ($httpProvider, $locationProvider, $translateProvider, $logProvider, Env) ->
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    encode_as_form = 'application/x-www-form-urlencoded'
    $httpProvider.defaults.headers.post['Content-Type'] = encode_as_form
    $httpProvider.defaults.headers.put['Content-Type'] = encode_as_form

    $locationProvider
      .html5Mode false
      .hashPrefix '!'

    $logProvider
      .debugEnabled (Env.env isnt "production")

    # i18n Support
    $translateProvider
      .translations(Env.locale, Env.translations)
      .fallbackLanguage(['en'])
    $translateProvider.use(Env.locale)
]
