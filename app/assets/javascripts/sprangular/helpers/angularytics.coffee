Sprangular
  .config (AngularyticsProvider) ->
    if window.ga
      handlers = ['Console', 'GoogleUniversal']
    else
      handlers = ['Console']

    AngularyticsProvider.setEventHandlers(handlers)

  .run (Angularytics) ->
    Angularytics.init()
