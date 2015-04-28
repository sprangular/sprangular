Sprangular.directive 'whenScrolled', ->
  link: (scope, elm, attr) ->
    $window = $(window)
    $document = $(document)

    TRIGGER_OFFSET = 100

    $window.bind 'scroll', ->
      if $window.scrollTop() + window.innerHeight > $document.height() - TRIGGER_OFFSET
        scope.$apply(attr.whenScrolled)
