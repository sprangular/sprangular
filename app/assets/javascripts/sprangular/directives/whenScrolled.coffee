Sprangular.directive 'whenScrolled', ($timeout) ->
  link: (scope, elm, attr) ->
    $window = $(window)
    $document = $(document)

    TRIGGER_OFFSET = 100

    triggerEvent = ->
      $timeout((-> scope.$apply(attr.whenScrolled)), 0)

    ensureScrollBars = ->
      triggerEvent() if window.innerHeight == $document.height()

    ensureScrollBars()

    $window.bind 'scroll', ->
      triggerEvent() if $window.scrollTop() + window.innerHeight > $document.height() - TRIGGER_OFFSET
