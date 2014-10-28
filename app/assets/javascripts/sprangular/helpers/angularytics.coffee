Sprangular
  .config (AngularyticsProvider) ->
    AngularyticsProvider.setEventHandlers(['Console', 'GoogleUniversal'])

  .run (Angularytics) ->
    Angularytics.init()
