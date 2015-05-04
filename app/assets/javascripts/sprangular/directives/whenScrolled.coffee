'use strict'

DEFAULT_TRIGGER_OFFSET = 100

Sprangular.directive 'whenScrolled', ($timeout) ->
  link: (scope, element, attributes) ->
    $window = $(window)
    $document = $(document)

    triggerOffset = Number(attributes.whenScrolledDistance || DEFAULT_TRIGGER_OFFSET)

    triggerEvent = ->
      $timeout((-> scope.$apply(attributes.whenScrolled)), 0)

    ensureScrollBars = ->
      triggerEvent() if window.innerHeight == $document.height()

    ensureScrollBars()

    $window.bind 'scroll', ->
      triggerEvent() if $window.scrollTop() + window.innerHeight > $document.height() - triggerOffset
